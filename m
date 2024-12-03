Return-Path: <linux-kernel+bounces-428965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A571F9E1576
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B86162F68
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A6D1BE251;
	Tue,  3 Dec 2024 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Pj13g+O4"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6472E156F45
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214031; cv=none; b=Muz0Tp8+Bhk1kEExjbDSWAq1aK4Lh6M+UfAU2Rmt+aZo5xabI4LSoOdL7gQr8xfyhcVLRtRf+tJ+9YwMhXLpC7JJjSDEtdIY33E107wbVe/FvIdeD0uXkeaZFaDNxLN219FtlL+8Cz+AWMhRRGwP6aBlHGlqSrdGVJWTO9LGlDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214031; c=relaxed/simple;
	bh=fGJkap1WTg6IueqDR5QNwSv0nTBzoV76mMuGw6Sl+JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7OxuScRRehSKU0ET5wXKpISyadbpBzN9LudZF8383w7EGR0UWg2Jw3A3LDRiBwuU3itXvsxIqXKEeFfvVo2sYH7zG9iCC0SRcPnyW8bj9vtm7EkKucrUwWa8P8enw41Crkv5QaieVPeZihM8Qnrkh5SDGvT0azMudK9qryBSGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Pj13g+O4; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffdbc0c103so72495381fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 00:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733214026; x=1733818826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGJkap1WTg6IueqDR5QNwSv0nTBzoV76mMuGw6Sl+JU=;
        b=Pj13g+O4hILWn06T2f2kmuMWVQi8p82c7lgsoqho5wf5lsOq95R/gKmKplGuM277YS
         LfivtNG1L8v6uoNzaCN6Osy8mpfpoO+2R5PggibwwjslAGR5TNmWj8f2vDOf3yeZeb+V
         UlEDTQjOkjdB4uN1OZ8pGaM8AifBwIBGvqDFXWMJGqvf/IN2O8FT/60I+9sP5tC+pzFz
         c3qIk6GdQ6x1d15bBjbodWyEqn1+uaIRQcfeKUnhrVrVj9Cc9BCsZERzDtl0BDZYBdWb
         YEFkD7STKUv6s5pWUj0TMMY/MJYDFGg/Nk4TfbCMd7JPSwgZI7q5cKFNu30B2UKGXtC5
         ilzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733214026; x=1733818826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGJkap1WTg6IueqDR5QNwSv0nTBzoV76mMuGw6Sl+JU=;
        b=KEQYhtdIkgVHjHegbPDNvzV5Glj1/vlWpocmmm3YIsw6ymztO3zIXCC+dQO/3qCQuZ
         zW1kTQ8gE5YdBy7DtWNTabqWEWrtIFpeQlYMceEo/3+R0eoSI7qejZCCml0WG77RCJJZ
         f/nvPGnHPBihIggLYm4ncL1VdbpLkebDEHffeUp2zpL/9BxV3/jgyw/nIhepr51tqu3o
         whQESxDUBarzUDXYRKUm6T5nxN+9ypibOjwxz1q/ebrzRzEE/jJz6/0O3yyC2DFNWis/
         MTmRhxF4qyoejGB8w2C0uy0ddbm9Vqh2oDTE4F9OnC29UmzL5EBhX559syczfkdQGNmm
         a8SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuBtf95wJ8Qm9utH6QrddwJzVNSrqMFXGakYyY3w/JboCEoljKjm3QAd9XIq3Z9nSQiWvtrhNM5YmtPw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKjyEpslEotSYT+O6yvwPve1HKIC+xb/TypdxqfOTGuBGNdUew
	JMWfvzrUbLC/mUsBeEC4OU7OKXU9mgnquzDcD9a+ANTL4pf1IMUcEBmmOOJ4tYqJ+C4cRoY3gxu
	Isz/JnSZxdiZ8ZkpBc791ZrFOLjyAkZpxRVIwBg==
X-Gm-Gg: ASbGnctqCtI6/S65WGrNYCUXCWmsWD4m3TkCQdMKeEsbEEmCqgmsSCcos7Pip30xDIl
	OHg/LBGGpBQaSSlQOBpJK15O5quSyZrdtn7AvAANrfbe673+0K5hR1mzzAxCn
X-Google-Smtp-Source: AGHT+IGv5j81UR35BUm92BdCNXhtAfGCp3+txElbTevIkFrX0dXOOEieF3S1EHxtB+DeutvtSMJ8LVptI11DRyjMDsI=
X-Received: by 2002:a05:6512:3ba3:b0:539:8f3c:4586 with SMTP id
 2adb3069b0e04-53e12a3930fmr1166092e87.55.1733214026423; Tue, 03 Dec 2024
 00:20:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
 <CAB=BE-RVudjkHsuff5Tmg2sumjDkPKpQ9Y0XN2gZzPFxUGa+hg@mail.gmail.com>
 <b68945e3-3498-4068-b119-93f9e5aaf3ad@linux.alibaba.com> <CAKPOu+9iDdP9zVnu10dy3mR48Z1D0U1xyCuZa3A6cYEFKD-rUw@mail.gmail.com>
 <0584d334-4e75-4d35-be33-03d6ff7a0aba@linux.alibaba.com>
In-Reply-To: <0584d334-4e75-4d35-be33-03d6ff7a0aba@linux.alibaba.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 3 Dec 2024 09:20:15 +0100
Message-ID: <CAKPOu+8=ys1YMvGhmqjCru76jD6qah+0JXQo9-ChqhD7YxEavw@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix PSI memstall accounting
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 9:15=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
> But I guess you could record more frame addresses to get the caller
> of readahead_expand()? e.g. __builtin_return_address(1)?

ok, I'll try to figure that out.

> Also btw, is _RET_IP_ stable among all cases as readahead_expand()?

Yes, always the same address.


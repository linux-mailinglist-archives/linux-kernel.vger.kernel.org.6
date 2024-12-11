Return-Path: <linux-kernel+bounces-442139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 194719ED880
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9E1161C18
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CAD1E9B3C;
	Wed, 11 Dec 2024 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="buDw+RS6"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870821C3038
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952351; cv=none; b=Y1Aa13sH+LWVemY7/RRaydO2f9nr+wNvTXtmX3nndZ/mJgF6R6yhCFEB4PJxm/3oF/XgpUJEO5vjBRNxRrNSLpaQrv+mxvTheR7TtvlBj/mgKcLHYtZ7J3qcG0g1frgVe2TK6/hnVikU2PE0WdGhXRoqcN/XvRqlACUBat/eZK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952351; c=relaxed/simple;
	bh=FckW2ieXpxLpsV5Kvr/prm5pryu+6b9NkZdq5282QPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTSTJwM6ssfcZWrufhS3mhJ9hC6um5oY0Pgw9MHYtRlGOUXQ8OnixrQUk+OsgfBmJDqquypazOAeSrS9SQfO87Fd4Sn5wBlKW7nn04apjUlLSmYT8fUR3seNVeKkum2MSILN3Ift5fKP0o1+5g2ZfNOU7ejmwunxD5zphq19Akw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=buDw+RS6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa6aad76beeso320260766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733952347; x=1734557147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+5nwrIeBTzsYuFpuCO+Y1X+t/MbKQKp0hKGhDauM7q0=;
        b=buDw+RS614quKQR1JcPgk+TllxgxBpUzz5FRO7ImuuOXx9jEE0PsmSEPqEJYfU08jU
         DD3ovoELkFNfhR2DeHC2XBfJp+ULdUXSuNJBytY0fnJYZaMuH2Zzxo8wrS9omxabGYng
         15ob9yoaHMv8UiLatW7k7+g53BPE1z8asRYRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952347; x=1734557147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5nwrIeBTzsYuFpuCO+Y1X+t/MbKQKp0hKGhDauM7q0=;
        b=elhUt+wJp/zS4w/ISmqJlJfJtxIF2PExK9yBOr45sr5nn2biClBg/mDkCCowIaO82B
         bn/PfmsVkJmS0trEjmQq37xg1na/dLuXCsqVYwFVcbgQbygslV7ePblz3hs2BHtDaA/8
         N548+n9YruZZFmsJsVi6CUAdme6MkxH0rVQFV0Q+3RjXV+7txvrjAWnaj+TmMSUT7ihu
         X5uVVml67QKGf9SH3dw5t4V5fFI/IMHQzO1ngt5Nn09fYIci1PNTWsiSAW5Bk0Z8gI47
         6p9imaYPKC+VjZzg2Ljyd13NPTIu9MERUuH4FPUR3/l4u/6BnN7TKaGNwnBdYGyu8dLi
         YFJw==
X-Forwarded-Encrypted: i=1; AJvYcCXVUyWVkrM6Xk3XsLiTV5MfmGAWpbPVIWBovK2lTqwe32GEx555MdsIVI87CSICc3V6nsfUMWmP7FLqEPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLBhYIQ6ngX+vTj1XGyNVI53tyNFE97cfQHUgdNcPj/RLUSHGD
	Thqj6p9OKdim13e7oK7zwtj/sJ01TR8ytxYMmEqPu4WnLYHaY0vCov4JDjIjv46zePd/TOVb6Xr
	VAWU=
X-Gm-Gg: ASbGncs97CVfWNrjZh0SvyFp/4pT7hiPGhV+JIFhD8rU08zRsrIC8grGrsETjIBIpvo
	//8oRJN0DZ0xeKJJlX/Sazf/k7lIVN4VhhJHX1EhysN3TTji4O5SeJfCUjq1DIyfEFLSEFe+aAu
	IptOSFu55VjdMQQif+E43uGgLpUU2b+rM/gxJVqVjYyDB1XcBVWc7e0qqybKV0BiuGnOCBQR9Ne
	9L1Q/t+Fi1O3NTGqcyWv5Arx6B7nxMHC2DBPL2dHKJpQLZdCvML/nK0ngbW/YoUcgulByo1NyyA
	r+LZhpNR/fdSlqOQNHQX6oI1MQwa
X-Google-Smtp-Source: AGHT+IG4vWP7n2sCdQmlZgt2STQC8YmzJj8QB1CTI00uYcuJ5AXLiDYl/6SsP6Jq2Riz4hRs1XDs+A==
X-Received: by 2002:a17:907:7843:b0:aa6:6c46:7ca1 with SMTP id a640c23a62f3a-aa6b11418a0mr342132266b.10.1733952347586;
        Wed, 11 Dec 2024 13:25:47 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e6c67sm1045520966b.187.2024.12.11.13.25.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 13:25:46 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa6aad76beeso320257566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:25:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZqU+IesEA2ESXcq89eOXnadqn1RaRAaclluIHJ2X7gDbERA+NkIYDOisgrnjie3/qx9a2txG/pYUAlIU=@vger.kernel.org
X-Received: by 2002:a17:906:2182:b0:aa6:86d1:c3f8 with SMTP id
 a640c23a62f3a-aa6b1397b77mr332011966b.39.1733952346369; Wed, 11 Dec 2024
 13:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1mzu4Eg6CPURra3@google.com> <87v7vqyzh4.fsf@mailhost.krisman.be>
 <Z1nG-PSEe6tPOZIG@google.com> <87cyhyuhow.fsf@mailhost.krisman.be>
 <CAHk-=wice8YV5N1jjyz42uNi-eZTvG-G2M46qaN7T9VsSaCP_Q@mail.gmail.com>
 <CAHk-=wiC3evUXq8QTcOBFTMu1wsUR_dYiS8eGxy0Hh7VbL55yA@mail.gmail.com> <875xnqudr1.fsf@mailhost.krisman.be>
In-Reply-To: <875xnqudr1.fsf@mailhost.krisman.be>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Dec 2024 13:25:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+ZB4fNiMTHOYo2__-NnBXryQwxJ_bHN+cUDsfBBt_MA@mail.gmail.com>
Message-ID: <CAHk-=wi+ZB4fNiMTHOYo2__-NnBXryQwxJ_bHN+cUDsfBBt_MA@mail.gmail.com>
Subject: Re: Unicode conversion issue
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "hanqi@vivo.com" <hanqi@vivo.com>, 
	"Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 13:11, Gabriel Krisman Bertazi <krisman@suse.de> wrote:
>
> This solves it for directories with inlined dirents
> (FI_INLINE_DENTRY). but for large directories, we use fname->hash to
> find the right block to start the search.

Grr. Dammit, the hash should always have been the original hash of the
original actual case-preserving entry.

Oh well. I'll continue to just absolutely hate case-folding, because
while I suspect that it *could* be done correctly, I have yet to ever
actually see any filesystem that did so.

            Linus


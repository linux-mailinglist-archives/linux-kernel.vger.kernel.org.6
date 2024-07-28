Return-Path: <linux-kernel+bounces-264457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C77BC93E37D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 05:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A94D1F22074
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 03:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F7E3C24;
	Sun, 28 Jul 2024 03:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LUjuwFRV"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BE41878
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 03:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722136624; cv=none; b=fopVSw+CRiC/o2mjxXjfbUJQL5pHKS05pnTjUHBPhC0UvmqGCPc5lsnMU0Pgs9yXInNz5WdiXyvOoN8XpfzAXXeFavV7ccnxS5Tps+oFZ2Ws6+Lf68QwE768a8c3MrFDx/lUAD4bNlJQgp8IbRMXsH5lemB72kIVSGsTbLQcPwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722136624; c=relaxed/simple;
	bh=qEo/9Or08UvAowho9Zrgf+1Yho0yllWXoK4yuUDNzfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NM/X5FZONUkpC0mhplRlRTrpf9e16LR93SzAM1m4S9k4T0xm9rBCQDzEC+tLHB7a2vBR1b7fAy9zV+xq46nZwLt5gvsoPMwJIdRdJ4o7Nqy0//UZ4TaLE6ph9n26BXbhdjRtdlMMGc/JXUUvZ2woemQKwspCtS6cW5j/UxDv2n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LUjuwFRV; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ef2ed59200so29811151fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722136621; x=1722741421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KLxdjUr3nZZ/xXHM7u/PpsffYwjEQJpfVQzmD3d51LU=;
        b=LUjuwFRVifsR1qSoDn38whwavZjhO3yukhWgqH6Jn5/X+XhZ8USP5xDP4jzeaJQx9J
         QQdnc92errqf9EakbGO89Zvw4tC/xh24YHlNY2DGk0nGMLXWifKsDILjO7XU1/JiOnpj
         VA4hckaKx97Tx2WZPlDIC8y6USNLEPgAsnH2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722136621; x=1722741421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLxdjUr3nZZ/xXHM7u/PpsffYwjEQJpfVQzmD3d51LU=;
        b=q9VyyrbsHba97PWCXmPauEXf0x8yMRM1YvUB3PzeR8PdHCLdC7vsuenhaHXzAiqXJZ
         BVjfHX5s+n8GjB99bxScMyOCmM9NOXY+ZFKpY+DdScr4ATdc87dfz05RwTN+V8IVWQWH
         TGSl/nUzXXpCduFNH3WVchBtYf5yppPT6ODyL7/y524u5up3DDZ5PRfHdcZCsQ022MZq
         /g6h67ePlK0C03RM44Vq5pnYK8YeiuKhDxVajl1fFfXU6PgKUrUCnNPWwpuJyh/lRDU5
         5+ue78xwNzFeSlrJMbr6mr8gAA3faPc2r70GP/sHlGLxhrxsiwUjVac1IVI4D3FLwdAj
         wzxA==
X-Forwarded-Encrypted: i=1; AJvYcCX2PvCll3klxoZYGOpjXfnRNMQ+azw/obmqsPjP1G2zz3m6weh61/rsN+FjDz50tnDkpJiveABV9I+ufw2UDcWLZHqkjWkps9RmNmNg
X-Gm-Message-State: AOJu0Yx2LuSiv3nmoumNWp/PIdbdM0RJh+g+902sG6QzjrVEclChzITG
	CiG4Jn+DjNAJ+NBrMep345XnuVNIGlSr6p88VZ7jsebJEkhNgTgtHA+k75cxdB2NpZBTRkglVFi
	9LUk4dg==
X-Google-Smtp-Source: AGHT+IHxQKKmvaIh8Xo7LteA0uZfHwAXzlWy0lWLL1lrJM5UrctCrgu/VYxtLu/3Q8ik6yLWNLQ6Zg==
X-Received: by 2002:a2e:9091:0:b0:2ef:26dc:efb3 with SMTP id 38308e7fff4ca-2f12ee031cfmr25481611fa.2.1722136620796;
        Sat, 27 Jul 2024 20:17:00 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf30224sm8520151fa.46.2024.07.27.20.17.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 20:17:00 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef1c12ae23so29063111fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:17:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0ehBenShAABD7U8EJx3+HQuIGncVd17CbrlwX8UZZFDFtvQbe7N6WmdxzQWhEAx+RMlz9YFtcAS5bwtvmdzwe27GuCE1DvAuMWCF8
X-Received: by 2002:a2e:9bcf:0:b0:2ef:1d79:cae7 with SMTP id
 38308e7fff4ca-2f12ee14eb5mr26336921fa.14.1722136619815; Sat, 27 Jul 2024
 20:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5msuLY9XywuKvnggezTdjCBQx8HDfYhHNstS-Yijz15sdg@mail.gmail.com>
In-Reply-To: <CAH2r5msuLY9XywuKvnggezTdjCBQx8HDfYhHNstS-Yijz15sdg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 Jul 2024 20:16:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgS+TLGrPpcL4fy+NRRyuXbd-mJed50sXoqsPR0w75Oig@mail.gmail.com>
Message-ID: <CAHk-=wgS+TLGrPpcL4fy+NRRyuXbd-mJed50sXoqsPR0w75Oig@mail.gmail.com>
Subject: Re: [GIT PULL] SMB3 client fixes
To: Steve French <smfrench@gmail.com>
Cc: CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Jul 2024 at 17:35, Steve French <smfrench@gmail.com> wrote:
>
> Please pull the following changes since commit
> 33c9de2960d347c06d016c2c07ac4aa855cd75f0:

Hmm. I  got this twice.

After looking closely at the _almost_ identical emails, I assume the
re-send was because the first one was html and was rejected by the
lists?

But in case there was something else going on, and the second email
was supposed to be another pull request (perhaps for the server
side?), please holler.

             Linus


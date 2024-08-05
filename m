Return-Path: <linux-kernel+bounces-274864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC34947DCD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58271C21C98
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C467762D2;
	Mon,  5 Aug 2024 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WZkbVZUM"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C887344C6C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871056; cv=none; b=ObuaLfRwc3KMpxiSLJ0YD77eAw498MaUSwVev/8XSAbgYjfbKTtg2GcV2wdi8Y1pPvJf9shbB94Jx+VcMFQrCnlH63xeQ01KQDlI4fa655QiRvANOkkrVvfT6Ubx5oXp4URlaYUxbBVgDaGqbtLs7Y1k///kCHKDVYwLDhCrEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871056; c=relaxed/simple;
	bh=cerrIVy++QrwA53PTo40KpsqW+hfdtxcQpRNks8sD1o=;
	h=From:Date:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQTieAkXpculZ0PnAoK22jCSpwGnC+25dnDoQ06FXVpyqCuhA8Wn1szCJivfbNcp4l6xgVmIZICZIZyh47OIkaFnikpC3+43ebkSBk/lY3DqlcKQibDTmzBgL6sE+4SfSJXiI678CAwSipIjL//rHlsc8aFF3EUG1NQHpUfAfic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WZkbVZUM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7d26c2297eso1337988666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722871053; x=1723475853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xW+L6kNIuFioJ5rjDKnCuxYZ724u5jfAfcF4VZ+PAvE=;
        b=WZkbVZUMwKYZBEPqxY+72J1rNJ16UustdsVI7i0edgQnbUw1i1XNizMyunYfjVjzKD
         0VFNb7TKiHQkNig4wBU3pASrjbNy2IDzAegkzq+72hw/TpVR5rEduHq7FF/9JJ2x7D4d
         Z8/bZedEe7Ie5CEhqsdILJCbv5nvbSN69WR9+9h6p6V3TxTbVB97ZDv90frYP2LOrcfH
         v4eDsU3aE/0loQf9nlVoW6pXjqlT8t2F2trhIS6O5W47G0t652PFfkOwHS4qa0VXSpxq
         PsTIXEGLdHEEEP82VSv4PekKQlGVu1RpPd1EFIEOMuUcchWKhSY0ESqjcfSIyuctNfCd
         VZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722871053; x=1723475853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xW+L6kNIuFioJ5rjDKnCuxYZ724u5jfAfcF4VZ+PAvE=;
        b=HQWprTywy5yB9tceW4TB7YtVXXzhYhtJ50GnfRr3/kR/OsfCpLb5aBBR5/vW04I0f/
         fl7Tg9AHia9VRoOU8WtxdLlHiDvlq3/FXgOzdGvZkv/hKXMM43vv/u/PttVF0Mbzyueh
         AecHTJTD9hj8BInJr6aZUBSHbkj4yPe+yDNN3cIfEOtlnZtg013BytkQ43y9Bmh86RDQ
         /whRS0h+5F1JNw4cZoJGVODPtVY/Zjgax05VWoZQd5KgZZZ0kf+K9eZrXgEPYLNZCamW
         Fz26b2I/mTw3SKRxGvq+33QpFlgWC8jn93C+lTUIZ5dmj5/8SBp5uZ5O0BEPgbjq0I6I
         IdFw==
X-Forwarded-Encrypted: i=1; AJvYcCUqOjQ/GAVM3Od/gDxB9067s3aLyDgQ8BEKo+GNrBiX8jOtlEA5MptDbW61RWugXZm2AjpxdZjZcE5kYPabOXEjD7r/JRfyT857r9yk
X-Gm-Message-State: AOJu0Yyqxpz1nUTIKuTAxh8wAXjmPZm8RuToiOVIYcf+vCpO9D2sXA7H
	Vu85uzbHhPpn++NMZjpel5wd5gzUTRjD5urnb59dXEzXperyNkMyqYVCZKFi9vo=
X-Google-Smtp-Source: AGHT+IG5voRnVt4VBcz9JPN7Wlg0F9fRCCmBXH791ZTtO6sf86pBUCsbXkJzE1B1Mo5tTAsDDSmBwA==
X-Received: by 2002:a17:907:2d29:b0:a7a:9226:6511 with SMTP id a640c23a62f3a-a7dc4fb0ddcmr969429466b.31.1722871052866;
        Mon, 05 Aug 2024 08:17:32 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d4520fsm457910266b.110.2024.08.05.08.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:17:32 -0700 (PDT)
From: Petr Tesarik <petr.tesarik@suse.com>
X-Google-Original-From: Petr Tesarik <ptesarik@suse.com>
Date: Mon, 5 Aug 2024 17:17:20 +0200
To: Petr Tesarik <petr.tesarik@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Sourabh Jain
 <sourabhjain@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Baoquan
 He <bhe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Eric
 DeVolder <eric_devolder@yahoo.com>, kexec@lists.infradead.org (open
 list:KEXEC), linux-kernel@vger.kernel.org (open list), stable@kernel.org
Subject: Re: [PATCH 1/1] kexec_file: fix elfcorehdr digest exclusion when
 CONFIG_CRASH_HOTPLUG=y
Message-ID: <20240805171720.3b661180@mordecai.tesarici.cz>
In-Reply-To: <20240805150750.170739-1-petr.tesarik@suse.com>
References: <20240805150750.170739-1-petr.tesarik@suse.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

+Cc Eric DeVolder (current email address)

On Mon,  5 Aug 2024 17:07:50 +0200
Petr Tesarik <petr.tesarik@suse.com> wrote:

> From: Petr Tesarik <ptesarik@suse.com>
> 
> Fix the condition to exclude the elfcorehdr segment from the SHA digest
> calculation.
> 
> The j iterator is an index into the output sha_regions[] array, not into
> the input image->segment[] array. Once it reaches image->elfcorehdr_index,
> all subsequent segments are excluded. Besides, if the purgatory segment
> precedes the elfcorehdr segment, the elfcorehdr may be wrongly included in
> the calculation.
> 
> Fixes: f7cc804a9fd4 ("kexec: exclude elfcorehdr from the segment digest")
> Cc: stable@kernel.org
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  kernel/kexec_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3d64290d24c9..3eedb8c226ad 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -752,7 +752,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  
>  #ifdef CONFIG_CRASH_HOTPLUG
>  		/* Exclude elfcorehdr segment to allow future changes via hotplug */
> -		if (j == image->elfcorehdr_index)
> +		if (i == image->elfcorehdr_index)
>  			continue;
>  #endif
>  



Return-Path: <linux-kernel+bounces-392292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5B79B91FF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2B21F219CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7E019F41B;
	Fri,  1 Nov 2024 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="H93Ybn2E"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349FE3BBE5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467844; cv=none; b=rbp7XJvXpJxi9XuVMSn+9AD02JAj31X/tbA3RohGL+uQhclRH0FGqz/UcRUSjMdFLK3lxn8S9a//OkJn5UBEH66hRTjsW4+xLJVOb0C4p2vrisuqWsyK9BHVvWe4auG9AxSc8qU/+kaur0ScyFhKPqIU2CrdR96mZT2CB5Nbqlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467844; c=relaxed/simple;
	bh=amEJ1LEFH79GFtZrGEm3xqcPhLiiNG5FadDnnhcG3+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdUl/j8OcXvNG6c0sME3BQ9Ep1lzh58MbvRgTlCZtdSVvJAnLZMuoM/JPjSmrtPM1vt61PC1J1f7lvUwnJJv3OhhEXDjneF/D1R1o2y+zQZkA14rzIxrohpCrEuToy3UHgCpj90jEZvvzSnW33HiVDsc1BB5ZcFfB7bzgWslPFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=H93Ybn2E; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4609beb631aso13189961cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730467841; x=1731072641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O+zxaTrh7HADeaQip64uvXVpGpMgvPdgqlePcZ62Y0I=;
        b=H93Ybn2EAHYjCcgmoMehSdQM2nNEpdoVlYmKuH6y/5w90dUpfmqEFeo3mIvQtNi2m/
         EMmy5TKiBk0KggtImqJ77uz82RA+7oYO1RFAEV6r0moB+XpCeHs8ayDlTHs0s/44xO4p
         t/7KpYGKOXRjDxCPUK/VRhPCCzG6bhJkh1Id0BAT/H1LbPMJt2q+1KbGj5gY18rcBh1V
         OX6pWEX2T1FAStAfpE6vM6waON84wllzJGEYzbDpnCu12Himdm3S8lXkrm39jxzYHlW8
         AndfLfO/IBoOYDJee0k7QRkJQ1klrQz/E0zunESa3yXMteEraES5q/NC/tR180O6MmhW
         z5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730467841; x=1731072641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+zxaTrh7HADeaQip64uvXVpGpMgvPdgqlePcZ62Y0I=;
        b=k6v0hKNaIEMkdgBZahQPjTgLSxveNMqQT9Xi1O1eIpRg/mvtjDdm31pd2lOyFdMzh1
         sLUlHMmR8Lg3JBz0bNZCUp9z1SNnX/g69kyw9SEQSFlaU7MM3JGFYhJrrywtUd0x+j/G
         Aeh5svxuo/EFIJl24OoLi2imt4i25rcSkLMSKFta1YZdCBpDas8bJSXifyERYOND11p4
         4q4g3FTAs+iczKj+f9fN8dRJCYjFVs1JyfoVYbdZMKjIwcaTti+VvDpMBYcCPhnFxdyU
         tIe480vKCrmjhoy7DNU/HZDafQ65Dev/DNHjCkh5oNbc751ZjRDoCqHq+6MfRq387gET
         rpqg==
X-Forwarded-Encrypted: i=1; AJvYcCUuny+QdT3cabHcrs88A10naWyJWjpj2su8whM595kG/ScSb4aZZ7OEWulutfRZfaNCC4gyo9GbzrOAncw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKKCiGIoQq4gIy5RLhD/znpz6VUpdvXi1bMSUvc8l53D6m7sgE
	okWflHlJg8bRBCA9/4e6dA+SRoClob56weU5tPm9v2te7/R/XB4FCA08f3ExTb0=
X-Google-Smtp-Source: AGHT+IE+EOVGC2mCMhtnwt/3GoIcBU1ivZDsYVQH624sCY48sw9XZqQuML9P4o193+v7BNLzgzWiYg==
X-Received: by 2002:a05:622a:1456:b0:460:a825:636c with SMTP id d75a77b69052e-462b86804b2mr40043091cf.14.1730467840881;
        Fri, 01 Nov 2024 06:30:40 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com ([50.193.156.113])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad0cac90sm18553271cf.53.2024.11.01.06.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:30:40 -0700 (PDT)
Date: Fri, 1 Nov 2024 09:30:37 -0400
From: Gregory Price <gourry@gourry.net>
To: Hugh Dickins <hughd@google.com>
Cc: Shivank Garg <shivankg@amd.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: use vma_policy() to get vm_policy
Message-ID: <ZyTX_VPXec4VThXx@PC2K9PVX.TheFacebook.com>
References: <20241101071350.402878-1-shivankg@amd.com>
 <8169912f-82dc-e210-862c-f6eb092db78d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8169912f-82dc-e210-862c-f6eb092db78d@google.com>

On Fri, Nov 01, 2024 at 12:37:45AM -0700, Hugh Dickins wrote:
> On Fri, 1 Nov 2024, Shivank Garg wrote:
> 
> > Instead of accessing vma->vm_policy directly, use vma_policy() like
> > other places for consistency.
> > 
> > Signed-off-by: Shivank Garg <shivankg@amd.com>
> 
> NAK.  The vma_policy(vma) wrapper exists to avoid #ifdef CONFIG_NUMAs
> all over the place; there is no point to it inside CONFIG_NUMA source.
> 
> Hugh
>

In that case we should do the opposite of this patch inside mempolicy.c

Only 1 place to update

~Gregory

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b858e22b259d..beffdc17aad5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1572,7 +1572,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
                 * or MPOL_PREFERRED_MANY we return error. We don't reset
                 * the home node for vmas we already updated before.
                 */
-               old = vma_policy(vma);
+               old = vma->vm_policy;
                if (!old) {
                        prev = vma;
                        continue; 


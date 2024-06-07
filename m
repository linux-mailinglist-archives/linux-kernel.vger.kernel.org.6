Return-Path: <linux-kernel+bounces-206469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C525900A3D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182AE289FAF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66C819AA43;
	Fri,  7 Jun 2024 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8n7caMl"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F224B19A2B8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777615; cv=none; b=IcOpyTj1R1S7w8mW1n/QfNsOjNDlVJF1FE5ojl2T4jQj3U22g19xuQ7kjOaUwVzlz9BUgLmcEqX/C3hJ4OXEXydSoqs0U5obQ7+bPyWlw5dtrE/vy7MH92fj5fSvNj/isW0rrwbpOreSh4oSI/62SZU7z7CK+bUR15WJXdjZ1lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777615; c=relaxed/simple;
	bh=Gw6nS2M7J7ZsnJv0Crt7SfUh5wfmNvcvaxLXWK1M8NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5ipEPHLk2kw2VWoCrvkCW+tam8BzkbyejQbyHz6R5tyHyZQtlqHGY8fsAhuW7wJcSGw7VkkQ7e5qg8w8ZHC0CXNVklr9xqTMKGKoSvQyN2UGK8oq7oB7ZkP5rWXjnt/p89/+vqIK8tlLpcA90TC88ld0PIfAAo3//TdPqcXtgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8n7caMl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f6c7cdec83so15511885ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 09:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717777613; x=1718382413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3gVI+4EfI4HDRmKgakUQr5g4UER8JPhiT77QrGDA5s=;
        b=H8n7caMlxUDWjILuo/Vb9v7dNQa7sMHSL/6OUr0eKDnv/eCt1bUTjkFBBNMXqqhovh
         LbgxC9niUua0sHsqNCMlVCQguuzIArhPqCnoBgkPPo5uNvAUPCnPrQlhX/jeZyotwzsH
         Nfipk9wm0sGQy1bAYnjxdNFSf0WhO7VXTZ7+AOAw/tbwL4hQiNhsBW+H3rzK+VhsVCqk
         K68mvpxnLH6ohsxC/oM4MVL/8VmEk8ehsTR8uMLwoDHsvE1o/ZaARMeY1dGx98oaqq8Z
         Fo1ZgIbkV2VHL7sjAeqjcVxKVORoSuFT3SE0ZjVL87BwvFF1Ww0UhW4nB3Lc826hXkrk
         HKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717777613; x=1718382413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3gVI+4EfI4HDRmKgakUQr5g4UER8JPhiT77QrGDA5s=;
        b=LRf7wBa5v/SiaHKP7kv73rt8zukSr41bZph+mGeeGnbd6CNc9TnNXz77chkmEV623s
         KUUkP3lO7m3WDCvpTWcHSQnyw+NYBwonMI4zypEHfuVIIt3dyB64awsj26qk3htnumg7
         SuMoMPVvRMvcpdEzRFeEk5dxGLj79zBiC+1P63DL9CbE5w6hfYixCIKY4aFHuhsLA/WF
         BNJMUuzNY9ncQImwwUJk2n4+eI56Y7Lx+c6ixgVwMSaNLSdA87ZWq/HkS+rRXdrkO+f2
         idex0hdhe5WAPIb6KWp0XN4Cen22VIJZcHtu5+hLkEhPOpU90ehstvJV1XSxNeSf5Xbj
         qC6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVG9PWUzXNfEQzY52jg5lYzvlbMX2QCEhArav+mMCndfyi6tJZ7m35lnAr3JJr7SzvVW4g6eU1JsCgGUr1XUbq+zlCsP16wIMJiYdS1
X-Gm-Message-State: AOJu0YyLIN00F09wNouregKhN2ykj+fgsLiROov0xJUyjNJ9dGq8Spir
	x99qNiRsnRIclti81MUCJFQJodCG+lVHC8qoDCVyQsFBK3Ln146p
X-Google-Smtp-Source: AGHT+IFUKScNa6tl6sjE61jZ7WNtMjos20FQFrYW96+322QI2gd9cuNA81ZuEBeYrurOHUcJbX+usg==
X-Received: by 2002:a17:902:e5c3:b0:1f6:81f9:cf34 with SMTP id d9443c01a7336-1f6d02f562amr39910745ad.34.1717777613191;
        Fri, 07 Jun 2024 09:26:53 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6da3ab591sm14621595ad.149.2024.06.07.09.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:26:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 7 Jun 2024 06:26:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] workqueue: cleancode in alloc_and_link_pwqs()
Message-ID: <ZmM0y40FJ4XVAYZa@slm.duckdns.org>
References: <20240606085216.3475033-1-haowenchao22@gmail.com>
 <20240606085216.3475033-2-haowenchao22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606085216.3475033-2-haowenchao22@gmail.com>

On Thu, Jun 06, 2024 at 04:52:16PM +0800, Wenchao Hao wrote:
> wq->flags would not change, so it's not necessary to check if WQ_BH
> is set in loop for_each_possible_cpu(), move define and set of pools
> out of loop to simpliy the code.
> 
> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>

Applied to wq/for-6.11.

Thanks.

-- 
tejun


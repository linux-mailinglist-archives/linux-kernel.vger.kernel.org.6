Return-Path: <linux-kernel+bounces-315270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBE196C038
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0E81F20F9B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DF61E0B8C;
	Wed,  4 Sep 2024 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fH8uktNw"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4301E0B6F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459654; cv=none; b=ZmjBzq/KxA5nbn2aEQgGIb67ms4pNeJkmq1qMoVjAo0hnsKCf6ajE6hYsqHVM3Poeb7jzrQs8PHHFBdlUx4/JhzgULU+awWNI352E09kisFYyllqGIFNThpHVrGPij5p0P7QMF9fzg3QYihLbU+SHh01E1PNVKjb6heato2pDe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459654; c=relaxed/simple;
	bh=qh7QzeNn1e5Pk2/QDNUNqCqsQHNRY5IQduu9qiuqNVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+mzRzgANJYbfQThQX/Fb742hF3ZjkHzA32OMlcAiAYiWdzg9gPD2x1uWXB2an3OyTR7WG6GeyMmxuEGQSyhObWwh4fvf+N2xDBt9z+vFdV9jvD2bIrPZWQw5vIm3GhfrRdMowvC5cDwT1GXQK/tEbNECN4ZJVvlm/1qnWoHkFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fH8uktNw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37747c1d928so607771f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725459651; x=1726064451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XEaydlTYxgFPTPFEB0dzIiGoTyUBH5i3vydc6ziFKbI=;
        b=fH8uktNwi6E7p2O2jN/AYsnQn7gxQTDAkXMTryAysQtsIRGz2iXLv3KzlsvSLaEePS
         gWCiduWGRYl3Jjjn1n3oRYwg2+MrFKA7X9SWg7ERxxgO3x6DYKCP7Y0ykZn38jUlLEzm
         wxne7Y/2p9tdxDrNfEd7oOfY0DowyyE4og6pT3UGlWXqzsvu0UJnqtdQ6iVSI+9CvBso
         ygE45aj+m+vViv56amAJvXQyrdpc2zPKwyZdgKxIX66RlaJmfBWSCrPboZnPOnf0e4t5
         PC7YxymNhoe2vjeMcgUuHCsF64sqqfLZY9evgzBRgZ7BZnbJXCzYg55pNxKe96I/lbcR
         uVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725459651; x=1726064451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEaydlTYxgFPTPFEB0dzIiGoTyUBH5i3vydc6ziFKbI=;
        b=rKSVEm2pFqrgstentBHofZiAqKBIK+oeV0dDr/F6vxPqn2kSDmsnMkhCi9Of8qKBsu
         0ti0CmrGTHMljyAUEhcXCnRXhrDuiYf7tVBK40qFakqFFzEWEaqlzgY2UPuI0ghKpt+x
         6rOmB4lJVsS6BO3SWsDg8p/KoYFD8q5hUqUQXyO55/Vu9oTXUF9RUWwHsQtANXzH/F7b
         v2XLNMY0CE99hv7JRboGOmaU5enPVn+tnP/1phjtLbxgtq5NWVqVrLYA8l9x+wHmLEnx
         QFERlKEMj+AE3Zx1HjO2V+SJP7ajoEVnU88k/+VVnPQeX74AZOmi9/CJD2xeAyAqT+Jd
         sXDQ==
X-Gm-Message-State: AOJu0Yxh+aMzuK58YjYeUlZC4XDX0I5Ysqog5kLaLA4Xfo3+IlHyJrhh
	bfxSghzlU8ubx8+iabnBXP/bgZvFhnwkcOFLomkgCBpWzZRMKB8savto6LTayxI=
X-Google-Smtp-Source: AGHT+IFvu23YtmgmJJOspMRG+OZzhhFnyd0zrYzvQFOKRrEcNpovBjG71JDZ6FXxaqiyKIbVMYTcMQ==
X-Received: by 2002:adf:e592:0:b0:371:8c19:f5e6 with SMTP id ffacd0b85a97d-374bf1c95d5mr10916746f8f.40.1725459650472;
        Wed, 04 Sep 2024 07:20:50 -0700 (PDT)
Received: from localhost (189-18-187-19.dsl.telesp.net.br. [189.18.187.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3550esm14128085ad.124.2024.09.04.07.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:20:50 -0700 (PDT)
Date: Wed, 4 Sep 2024 11:20:43 -0300
From: "Ricardo B. Marliere" <ricardo.marliere@suse.com>
To: Stuart Yoder <stuyoder@gmail.com>, 
	Laurentiu Tudor <laurentiu.tudor@nxp.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] bus: fsl-mc: constify the struct device_type usage
Message-ID: <gbwslua37jhptbwb2siui7jsdhyibfxvhkze7yxy4rra7jgdcb@btm7hfsbahwi>
References: <20240904-class_cleanup-fsl-mc-bus-v2-1-83fa25cbdc68@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-class_cleanup-fsl-mc-bus-v2-1-83fa25cbdc68@suse.com>

On  4 Sep 24 11:17, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move all the
> device_type variables used in the bus to be constant structures as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo.marliere@suse.com>
> ---
> v1->v2:
> - Added missing specifiers regarding:
> https://lore.kernel.org/oe-kbuild-all/202403091124.VOzGG1lj-lkp@intel.com/
> https://lore.kernel.org/oe-kbuild-all/202403090918.89zrHUF2-lkp@intel.com/
> https://lore.kernel.org/oe-kbuild-all/202409041701.8NfSraMa-lkp@intel.com/
> 
> v1: https://lore.kernel.org/all/20240309-device_cleanup-gregkh-v1-1-8ca586ef17ba@marliere.net/

Actually, v1 is at:
https://lore.kernel.org/all/20240219-device_cleanup-fsl-mc-v1-1-d206b8b90f2b@marliere.net/



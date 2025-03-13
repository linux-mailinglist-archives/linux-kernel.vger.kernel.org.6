Return-Path: <linux-kernel+bounces-559836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6DBA5FA75
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E248F189F43F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE5F268C76;
	Thu, 13 Mar 2025 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="irWk5vig"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0437D145A11
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881144; cv=none; b=PioWJMjC5q4cwkJk2sethrHhRjiPnx9jnYXGYb7C6xY9CO4Q88C1PaiExEJLkZoCnYvSxdg+ejIoQOTKq4Y1yszCZ1elZyTm6PqaCWqJS8vaeJM7XFbSbyG2k3Vnw0OrY3fvtLoqxep9b+EjD2pIYs3oZQx0pcuaUYcSQh5mv6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881144; c=relaxed/simple;
	bh=A8AtJQ9TXJXCum6G19u7JfO6nSprHwo4DLUis4JKzdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pg1pvS5KO+Td0B/dkOvkJFWQ8pAu5Xg92Qovo4AP73wqBXrZxdx/5tLr7afmmmUkTmk6Ssi6LBOOtCNGIa0lqNpyE6rtGd/nORTLwdYre5KkmptDWTi53hki7EMcNtYNPzDs8D1FZjaY97M2KauNWekU1r11t8Ie2ugIWI9g2aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=irWk5vig; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46c8474d8f6so10304611cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741881141; x=1742485941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4w37FL3B+Ve9xBUgAXtVYhnw9ChVr8Pqzg/e4uFmP8Q=;
        b=irWk5vigg7fORmZoRWqpPeLUaDAN45YovRW/66jhxR/2xAquXaqFgpd6uUdmys7t7l
         d4Oo1tq1RrUC+9OeXJtzQZbJVZ1WFsVdTRVz5dWXEp1nO3hVJ6OTTj1pgOmzXlWBwJb+
         4ohIebc/XcH0muc6t0lbKcEzws/eyP9JK54a/2gJUSb5+lwsFeQMqNbDrTgjihofgq2p
         jhKNs9UG1Hfcvxl6i7N5RwM30jCWC5EvBsWtRmDUMbj9TIsUlq0fkgqpbFAdaTPZ6bQ8
         q5ixIT0pH97SBXTQ83kwGtJVFHOUWvvRHGTEQeYWKwlRgWwaO9vdRfb6WqW7o9p68p+j
         hbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741881141; x=1742485941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w37FL3B+Ve9xBUgAXtVYhnw9ChVr8Pqzg/e4uFmP8Q=;
        b=p0t5JsGvKk3tQdnoc9GenS+xdCEFYEDaHn6uaw8hF0+o0tok/fDwhaZagfJzaNdeaQ
         XFXxJVdeMfFRSHMrHQulAoY54ZJOm842vARYsZyirujXU1btqOFsm9RSSxSbngSXwfNF
         3fZyHaXWTX7+CTqbV/OWXI537u8Dm0ksPJPzEL3104s4eOpGpkNxcmljRpB3P0qpM3S3
         R9L1Q6O4uehs+GjfFWVrEu+ydf8U+mKrW9Z5Wl9lAdZNBBp5GrIS9yuiKvAvOSgBSdzj
         uQ8eNHgzywOTqjHpyd4QpCWVCHOVUyR+8lCm4z3AYsCsHAkcllFGRzAgvZMulNXCn4DQ
         uiVg==
X-Forwarded-Encrypted: i=1; AJvYcCW9PyTPOO5ac8Goa3i9VDo3lGh+iLuQVR/UfK6bJWUDfg88TcZxyFhV+DEmf0VG3Hbr+bwvg55gx8wQN/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMRczP4f+DeKF9X8GMZ8T9nvleavXH9/aNlwIi7gzvJhtEcqrv
	p/nw0EY/nQEsasKdpsw0NeyZG0m8RDvOqqiuZhVv5iVbCfR4aGP7/GBojhfvQ2c=
X-Gm-Gg: ASbGncumPQL4bnwbdJNDqgcx2dCjeS0O9zvTj3Wqd468lJmOeqDrwWLXxvgK93NsEgz
	+1kVsP/W2kOj1ZTJMBvq2mxztPRVV0yZOpdzxgSkXiwcAkKZvpyxzO3XBTZHNBtqPAz4iCIllSc
	pnGhg7znUiDG0j+6RVmZaXuQnNrEFUzb1cprKaQOxMKWxcFi3bttBKhXLGY7f/S3xIIEuUOcxMc
	/n0yr84NOjk0j2FpFpf2X/svsifEtUMAU0XX4qo93G0MC0wnh4tuJ5QGdWqPaQ8sfcmYhyXQ+/7
	M8qIsOpFGng0MOY8jqIFTKFpATBsyMQZXQ/QAcBipaClmMPDMaRGI3h+0x4QlHDXzoLG6WbUUjY
	Eb2do/ehgaCC0s2x5bomTgAKW6P0=
X-Google-Smtp-Source: AGHT+IEsoyWweiNgBmaWSKSfpN7pyNhVfLT8lOAAvmtKf+Ddah15RIIeIcih94D/NjT9dh4sWhGcyw==
X-Received: by 2002:a05:620a:43aa:b0:7c5:5909:18f3 with SMTP id af79cd13be357-7c55e90fe47mr2004594185a.37.1741881140875;
        Thu, 13 Mar 2025 08:52:20 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d89815sm112187185a.91.2025.03.13.08.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 08:52:20 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:52:18 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v2 1/4] mm/mempolicy: Fix memory leaks in
 mempolicy_sysfs_init()
Message-ID: <Z9L_MgjuhrploEUm@gourry-fedora-PF4VCD3F>
References: <Z9Gs8i1FhJJ0eaiA@gourry-fedora-PF4VCD3F>
 <20250313063247.681-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313063247.681-1-rakie.kim@sk.com>

On Thu, Mar 13, 2025 at 03:31:38PM +0900, Rakie Kim wrote:
> > Is this correct? If kobject_init_and_add fails, from other examples we
> > need only free the mempolicy_kobj - because it failed to initialize and
> > therefore should not have any references.  I think this causes an
> > underflow.
> 
> Regarding the reordering of mempolicy_kobj allocation:
> 1) In kobject_init_and_add(), kobject_init() is always called, which

Quite right, mea culpa.

> 
> 2) The release function for mempolicy_kobj is responsible for freeing
>    associated memory:
> 
>    static void mempolicy_kobj_release(struct kobject *kobj)
>    {
>        ...
>        kfree(ngrp->nattrs);
>        kfree(ngrp);
>        kfree(kobj);
>    }
> 

I see what you're trying to do now after looking at the free-ordering
at little closer.

Lets do the following:

1) allocate node_attrs and mempolicy_kobj up front and keep your
   reordering, this lets us clean up allocations on failure before
   kobject_init is called

2) after this remove all the other code and just let
   mempolicy_kobj_release clean up node_attrs

3) Add a (%d) to the error message to differentiate failures

This is a little bit cleaner and is a bit less code. (Not built or
tested, just a recommendation).

I'd recommend submitting this patch by itself to mm-stable, since the
remainder of the patch line changes functionality and this fixes a bug
in LTS kernels.

~Gregory

---


diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 530e71fe9147..05a410db08b4 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3541,38 +3541,34 @@ static int __init mempolicy_sysfs_init(void)
 	int err;
 	static struct kobject *mempolicy_kobj;

-	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
-	if (!mempolicy_kobj) {
+	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
+			     GFP_KERNEL);
+	if (!node_attrs) {
 		err = -ENOMEM;
 		goto err_out;
 	}

-	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
-			     GFP_KERNEL);
-	if (!node_attrs) {
+	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
+	if (!mempolicy_kobj) {
 		err = -ENOMEM;
-		goto mempol_out;
+		kfree(node_attrs);
+		goto err_out;
 	}

 	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
 				   "mempolicy");
 	if (err)
-		goto node_out;
+		goto mempol_out;

 	err = add_weighted_interleave_group(mempolicy_kobj);
-	if (err) {
-		pr_err("mempolicy sysfs structure failed to initialize\n");
-		kobject_put(mempolicy_kobj);
-		return err;
-	}
+	if (err)
+		goto mempol_out;

-	return err;
-node_out:
-	kfree(node_attrs);
+	return 0;
 mempol_out:
-	kfree(mempolicy_kobj);
+	kobject_put(mempolicy_kobj);
 err_out:
-	pr_err("failed to add mempolicy kobject to the system\n");
+	pr_err("mempolicy sysfs structure failed to initialize (%d)\n", err);
 	return err;
 }



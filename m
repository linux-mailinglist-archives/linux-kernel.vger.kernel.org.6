Return-Path: <linux-kernel+bounces-279547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE0994BEC8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B03F283B1C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41C918E03C;
	Thu,  8 Aug 2024 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pOxJnrCc"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DA81DA21
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125033; cv=none; b=DaAHucdQUQW9xEJZlV4qh686cTs96VFRqMLP5Fpbmh8xFj3TXK+wtoyLtlVwMboTy6cEbJ7YcelVlkKn6N5FMPhKWeZiUQTPdOz67ob07+/t/QfXtvZ0DGFJacLRZ94iNsnLxnI527ZjmhhVWppeXaGGZK97Y/ndq0NN8TOf1lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125033; c=relaxed/simple;
	bh=PEQ3r/uIovshsLCposkpKs/y0ZXKOlxl+JM5bswhi2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPQh+/W49cEaIe5QcpgY3NDOhR137nXZ83n4dzDnfdvdZMNI4jGNfkyjIAjw1A186Jj4pQu3sv1l9MJN0Qs7DTV7vQ86QdcFacsnRv8Zahj2bAcayvX/Wc9QWP/9CEXUBREEVx3p3AUMbSp9tgIw/kvHcbFquAWUH/fHLr/1K5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pOxJnrCc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd7509397bso198755ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 06:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723125030; x=1723729830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0znSNwkhUMT9PQBUqs58RCLUinqyfQNAcZNdc4Xnim0=;
        b=pOxJnrCcHPEFuBcJTuCEhfp88NJyqMVvROZuHYr3uJ802kXgE0xXPBvEHMbbwf3NJ8
         oSfhfzpYtzfnXTKvU/X1pBDwQcJS2Lxe79el454hAN8MXybmIgw6hUcF4esCXjSKk6XS
         LwJIlaBrR4n9X+8GtUmyB20OGhcQUn7bhrMwJXguG8eQeFmr1LWzrb6PY7OXo+rsvHZP
         sAwBR2s2i0efUyXeMbaXvR621Ol697mmcP8gvNv2UX4govuwQVoieEFsgS7rljHXSEHv
         2q1//wSlOKlc5SAzC7RPuC1FvZyHLsnYTHRmOmjjYjYiZgzQ5DhVwq1YZGh/o+6L4CKc
         la2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723125030; x=1723729830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0znSNwkhUMT9PQBUqs58RCLUinqyfQNAcZNdc4Xnim0=;
        b=RDHuuxY1icPooeh/EQZb/94AiN/AicsxR2VkrSvUDfCDhbR0QcnFmzRx3RCibH3fbf
         e7rnIJzx+DwaHwhGTKdDkHzeaSzAghTUlzrE1/KRtegxp3nrEkPYpyKUSaTMmnQzlleW
         3GwYYiXjWasJMGmId27S9HhZrlHcUy66qN9TjUY5vKc6clbOWTdDiow0P+G0UAHvc5WF
         72UF/W8ONBnUTRe1X26LxH8PioErwLr1PmY+3Jul3JLbYZtyngd6rgopF5iYQHFeOD3U
         cZ7PZ4ueEUwIj7UqBKiAtt6fFL/baKfEHb3G9gXezudhPt/HefwTB1bCXCJxlfW8w2y9
         bZaA==
X-Forwarded-Encrypted: i=1; AJvYcCUyA7ufjCcFSU7DufnnoQ9Hf8LNYzl+bivmMmuNTXoyzjpOFtaDUOVxx1y4fa/S4PSBG4bxN804/d8yujk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbhsUW0k8R/oQ10Ag+XM7+23dcLITbIgG44HsIim8b68jaENXg
	cw2n9TnKtpt8PLfRCcsp5yE+DwttByQNyo+Fa4QWW0zJ6vax+cVr2mE08MyRYKGpUJwdR9Rkyz5
	eLv8K
X-Google-Smtp-Source: AGHT+IG7VQqD7cJBbHCXGULkx3FoICliQ4nYzASUZRwawtCQWrj15ZdkQeMWjWzClvQ919z+3EwfvQ==
X-Received: by 2002:a17:902:d4cf:b0:1f3:61f1:e340 with SMTP id d9443c01a7336-20094884a90mr2615635ad.13.1723125027627;
        Thu, 08 Aug 2024 06:50:27 -0700 (PDT)
Received: from google.com (255.248.124.34.bc.googleusercontent.com. [34.124.248.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905f85csm125051815ad.160.2024.08.08.06.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 06:50:27 -0700 (PDT)
Date: Thu, 8 Aug 2024 13:50:17 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Will Deacon <will@kernel.org>,
	Kunkun Jiang <jiangkunkun@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	wanghaibin.wang@huawei.com, yuzenghui@huawei.com,
	tangnianyao@huawei.com
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
Message-ID: <ZrTNGepJXbmfuKBK@google.com>
References: <7d5a8b86-6f0d-50ef-1b2f-9907e447c9fc@huawei.com>
 <20240724102417.GA27376@willie-the-truck>
 <c2f6163e-47f0-4dce-b077-7751816be62f@linux.intel.com>
 <CAN6iL-QvE29-t4B+Ucg+AYMPhr9cqDa8xGj9oz_MAO5uyZyX2g@mail.gmail.com>
 <5e8e6857-44c9-40a1-f86a-b8b5aae65bfb@huawei.com>
 <20240805123001.GB9326@willie-the-truck>
 <ZrDwolC6oXN44coq@google.com>
 <20240806124943.GF676757@ziepe.ca>
 <ZrJIM8-pS31grIVR@google.com>
 <315e95d4-064d-4322-a9d3-97e96c013b4d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315e95d4-064d-4322-a9d3-97e96c013b4d@linux.intel.com>

On Wed, Aug 07, 2024 at 01:35:03PM +0800, Baolu Lu wrote:
> On 2024/8/6 23:58, Pranjal Shrivastava wrote:
> > On Tue, Aug 06, 2024 at 09:49:43AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Aug 05, 2024 at 03:32:50PM +0000, Pranjal Shrivastava wrote:
> > > > Here's the updated diff:
> > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > index a31460f9f3d4..ed2b106e02dd 100644
> > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > @@ -1777,7 +1777,7 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> > > >   		goto out_unlock;
> > > >   	}
> > > > -	iommu_report_device_fault(master->dev, &fault_evt);
> > > > +	ret = iommu_report_device_fault(master->dev, &fault_evt);
> > > >   out_unlock:
> > > >   	mutex_unlock(&smmu->streams_mutex);
> > > >   	return ret;
> > > > diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> > > > index 0e3a9b38bef2..7684e7562584 100644
> > > > --- a/drivers/iommu/intel/svm.c
> > > > +++ b/drivers/iommu/intel/svm.c
> > > > @@ -532,6 +532,9 @@ void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
> > > >   	bool last_page;
> > > >   	u16 sid;
> > > > +	if (!evt)
> > > > +		return;
> > > > +
> > > I'm not sure this make sense??
> > > 
> > > The point of this path is for the driver to retire the fault with a
> > > failure. This prevents that from happing on Intel and we are back to
> > > loosing track of a fault.
> > > 
> > > All calls to iommu_report_device_fault() must result in
> > > page_response() properly retiring whatever the event was.
> > > 
> > > > +static void iopf_error_response(struct device *dev, struct iommu_fault *fault)
> > > > +{
> > > > +	const struct iommu_ops *ops = dev_iommu_ops(dev);
> > > > +	struct iommu_page_response resp = {
> > > > +		.pasid = fault->prm.pasid,
> > > > +		.grpid = fault->prm.grpid,
> > > > +		.code = IOMMU_PAGE_RESP_INVALID
> > > > +	};
> > > > +
> > > > +	ops->page_response(dev, NULL, &resp);
> > > > +}
> > > The issue originates here, why is this NULL?
> > > 
> > > void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
> > > {
> > > 
> > > The caller has an evt? I think we should pass it down.
> > Hmm, I agree, I don't see `iommu_report_device_fault` be called anywhere
> > with a NULL evt. Hence, it does make sense to pass the evt down and
> > ensure we don't lose track of the event.
> > 
> > I'm assuming that we retired the if (!evt) check from intel->page
> > response since we didn't have any callers of intel->page_response
> > with a NULL evt. (Atleast, for now, I don't see that happen).
> > 
> > Lu, Will -- Any additional comments/suggestions for this?
> 
> No. If evt is passed down in the above code, there is no need to add
> such check anymore.
>

Ack. I've addressed the review comments.
Jason -- I hope this addresses the report_partial_fault()'s -ENOMEM
return as per your liking?

Kunkun -- Please try this diff and check if it fixes the problem?

> Thanks,
> baolu

Thanks,
Pranjal

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a31460f9f3d4..ed2b106e02dd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1777,7 +1777,7 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 		goto out_unlock;
 	}
 
-	iommu_report_device_fault(master->dev, &fault_evt);
+	ret = iommu_report_device_fault(master->dev, &fault_evt);
 out_unlock:
 	mutex_unlock(&smmu->streams_mutex);
 	return ret;
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 7c9011992d3f..4c56da1373cc 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -113,6 +113,59 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
 	return group;
 }
 
+static struct iommu_attach_handle *find_fault_handler(struct device *dev,
+						     struct iopf_fault *evt)
+{
+	struct iommu_fault *fault = &evt->fault;
+	struct iommu_attach_handle *attach_handle;
+
+	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
+		attach_handle = iommu_attach_handle_get(dev->iommu_group,
+				fault->prm.pasid, 0);
+		if (IS_ERR(attach_handle)) {
+			const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+			if (!ops->user_pasid_table)
+				return NULL;
+			/*
+			 * The iommu driver for this device supports user-
+			 * managed PASID table. Therefore page faults for
+			 * any PASID should go through the NESTING domain
+			 * attached to the device RID.
+			 */
+			attach_handle = iommu_attach_handle_get(
+					dev->iommu_group, IOMMU_NO_PASID,
+					IOMMU_DOMAIN_NESTED);
+			if (IS_ERR(attach_handle))
+				return NULL;
+		}
+	} else {
+		attach_handle = iommu_attach_handle_get(dev->iommu_group,
+				IOMMU_NO_PASID, 0);
+
+		if (IS_ERR(attach_handle))
+			return NULL;
+	}
+
+	if (!attach_handle->domain->iopf_handler)
+		return NULL;
+
+	return attach_handle;
+}
+
+static void iopf_error_response(struct device *dev, struct iopf_fault *evt)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_fault *fault = &evt->fault;
+	struct iommu_page_response resp = {
+		.pasid = fault->prm.pasid,
+		.grpid = fault->prm.grpid,
+		.code = IOMMU_PAGE_RESP_INVALID
+	};
+
+	ops->page_response(dev, evt, &resp);
+}
+
 /**
  * iommu_report_device_fault() - Report fault event to device driver
  * @dev: the device
@@ -153,21 +206,38 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
  * hardware has been set to block the page faults) and the pending page faults
  * have been flushed.
  */
-void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
+int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 {
+	struct iommu_attach_handle *attach_handle;
 	struct iommu_fault *fault = &evt->fault;
 	struct iommu_fault_param *iopf_param;
 	struct iopf_group abort_group = {};
 	struct iopf_group *group;
+	int ret = 0;
 
+	attach_handle = find_fault_handler(dev, evt);
+	if (!attach_handle) {
+		ret = -EINVAL;
+		goto err_bad_iopf;
+	}
+
+	/*
+	 * Something has gone wrong if a fault capable domain is attached but no
+	 * iopf_param is setup
+	 */
 	iopf_param = iopf_get_dev_fault_param(dev);
-	if (WARN_ON(!iopf_param))
-		return;
+	if (WARN_ON(!iopf_param)) {
+		ret = -EINVAL;
+		goto err_bad_iopf;
+	}
 
 	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
-		report_partial_fault(iopf_param, fault);
+		ret = report_partial_fault(iopf_param, fault);
 		iopf_put_dev_fault_param(iopf_param);
 		/* A request that is not the last does not need to be ack'd */
+
+		if (ret)
+			goto err_bad_iopf;
 	}
 
 	/*
@@ -182,38 +252,7 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 	if (group == &abort_group)
 		goto err_abort;
 
-	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
-		group->attach_handle = iommu_attach_handle_get(dev->iommu_group,
-							       fault->prm.pasid,
-							       0);
-		if (IS_ERR(group->attach_handle)) {
-			const struct iommu_ops *ops = dev_iommu_ops(dev);
-
-			if (!ops->user_pasid_table)
-				goto err_abort;
-
-			/*
-			 * The iommu driver for this device supports user-
-			 * managed PASID table. Therefore page faults for
-			 * any PASID should go through the NESTING domain
-			 * attached to the device RID.
-			 */
-			group->attach_handle =
-				iommu_attach_handle_get(dev->iommu_group,
-							IOMMU_NO_PASID,
-							IOMMU_DOMAIN_NESTED);
-			if (IS_ERR(group->attach_handle))
-				goto err_abort;
-		}
-	} else {
-		group->attach_handle =
-			iommu_attach_handle_get(dev->iommu_group, IOMMU_NO_PASID, 0);
-		if (IS_ERR(group->attach_handle))
-			goto err_abort;
-	}
-
-	if (!group->attach_handle->domain->iopf_handler)
-		goto err_abort;
+	group->attach_handle = attach_handle;
 
 	/*
 	 * On success iopf_handler must call iopf_group_response() and
@@ -222,7 +261,7 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 	if (group->attach_handle->domain->iopf_handler(group))
 		goto err_abort;
 
-	return;
+	return 0;
 
 err_abort:
 	dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
@@ -232,6 +271,14 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 		__iopf_free_group(group);
 	else
 		iopf_free_group(group);
+
+	return 0;
+
+err_bad_iopf:
+	if (fault->type == IOMMU_FAULT_PAGE_REQ)
+		iopf_error_response(dev, evt);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_report_device_fault);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d87f9cbfc01e..062156a8d87b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1561,7 +1561,7 @@ struct iopf_queue *iopf_queue_alloc(const char *name);
 void iopf_queue_free(struct iopf_queue *queue);
 int iopf_queue_discard_partial(struct iopf_queue *queue);
 void iopf_free_group(struct iopf_group *group);
-void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
+int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
 void iopf_group_response(struct iopf_group *group,
 			 enum iommu_page_response_code status);
 #else
@@ -1599,9 +1599,10 @@ static inline void iopf_free_group(struct iopf_group *group)
 {
 }
 
-static inline void
+static inline int
 iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 {
+	return -ENODEV;
 }
 
 static inline void iopf_group_response(struct iopf_group *group,


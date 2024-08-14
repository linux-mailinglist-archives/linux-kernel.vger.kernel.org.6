Return-Path: <linux-kernel+bounces-286848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2D1952018
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F96DB2CFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D511B4C35;
	Wed, 14 Aug 2024 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5jVEtw3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23151B8E93
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652363; cv=none; b=heWIM28//rzhAqI2P48vtl2sGa0FxSMOfEXdq1CTIXZvb7WZGv7HWvbxqpYUeAQTrd9OvxUutBpk61FNEQghzBqA4eobuwJGmDoygm5eq/VLn8ucmeNHn/nzFMPO9xpExrk0bXzBKKvxB/ZQPoP1YB6HlDzfkVeFOfOIVuAAEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652363; c=relaxed/simple;
	bh=OwGhmYU9SpdjEP/Qg74+ZT0vmXSL65coCmc5E0UHD9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTjoFvb3PsoNlUoiLxpQv8873uktyrbMRBBQ9beVN9qhTsLB1tAvjHvIXJmgtDbJqyodXzu2mMk8x/dWJZ6XIwLGGe2mvIW5oYZla+2wwM0bogr55hrr0dEged/VQLTZaOtQa7+UcbTzsoNFo2k6lYYEVxSuXDQUlyWYB9tnWj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5jVEtw3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723652360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sKjhEHT5Khyzus+b/pzSGTlNSXgqg5g7ApvnqngqfJo=;
	b=Q5jVEtw3o7jGERQs/7q7NVk0SF72kJJwnEdD2PNMak4dvc7lIEOZEyI4+XdjdAlpmtfDHz
	JR+uoCjlXCoGRkVmkN+ERBQq7AhyiBF0aQulNljPVgoTnL+Lg0e71E7x+CDS8CvDATXEu0
	lNWFpul7hrdGBeRQs2JVHk4Yeg0zQpM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-iWKg3ueaMBu5jhqhuPzKHA-1; Wed, 14 Aug 2024 12:19:19 -0400
X-MC-Unique: iWKg3ueaMBu5jhqhuPzKHA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a1dc85c14aso819389785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723652358; x=1724257158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKjhEHT5Khyzus+b/pzSGTlNSXgqg5g7ApvnqngqfJo=;
        b=VcMvQJICJavK0x8PcCfUFG8O1xuySqHdUecH+nc1AaDf74OmXA7Oel+mbr2XVSwGWB
         rHpdP6PaaYyWAscnFZmdxRk/gsHdidL0/aa8C8NnsVLy7GYVlCo05IZJNDPRuPFk+Hn6
         nqpGOv+StKZ44DnMbjdajRbFKTHBJG2UzpkhbzYj1EmzNBTRZKeQNDFrHuWW0Xt6Lrig
         PU2OXLelWEwke/9x/17dkTUTixOsxH1rDizxM7xZyrL9bZJqTKBWpPO/AI/rV5/NtkMg
         s4EBZwC50cnU0stJZ1M01b10Ktb9TUkwM97X+x6BvXROrHyGtqLEeCyASqATcYpvQYbJ
         rZAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbov8W3fb94yIiWLmI07dYtSyyQzJn3MRLmx7cZB/QJvQdrXzo11CqwRIIDcInuK6kUHMlxDptx/lao1lKoSzHtjEQT63ClhCcyE11
X-Gm-Message-State: AOJu0YxkksumWOC7iwpd/zrT+72gIr4yU4oltvJYBc/9EwNlNcJuz338
	OHrATBTD/9TQI6QYYbiobgYC3XhMhP2hIpGq7aWJ16D185HzhWB1OCnkzWzxP3ZpK4+oXtptIAF
	i7gDm6sPDti5PzJZw/uVFvWS+a0Bqvdf+CxFJ3el8/6s7wNDfHlox9qtH/M3jeQ==
X-Received: by 2002:a05:6214:5c01:b0:6b2:bdcc:f45b with SMTP id 6a1803df08f44-6bf5d26aa76mr29082686d6.47.1723652358511;
        Wed, 14 Aug 2024 09:19:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt9hHbhI3xO/6YOemajUbtX/MgNEDnatt18EPskyAe5F9AR4KMUR9C9UJlEn1m9ge+IrtqvA==
X-Received: by 2002:a05:6214:5c01:b0:6b2:bdcc:f45b with SMTP id 6a1803df08f44-6bf5d26aa76mr29082496d6.47.1723652358093;
        Wed, 14 Aug 2024 09:19:18 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6a7a8c02sm2632526d6.10.2024.08.14.09.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 09:19:17 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:19:16 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] iommu/vt-d: Factor out helpers from
 domain_context_mapping_one()
Message-ID: <ubyjtqgr3seyd6w7oafei2g7illhxqwfpbfms7gyymt7sc7qup@zqutbrqunwxq>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806023941.93454-6-baolu.lu@linux.intel.com>

On Tue, Aug 06, 2024 at 10:39:39AM GMT, Lu Baolu wrote:
> Extract common code from domain_context_mapping_one() into new helpers,
> making it reusable by other functions such as the upcoming identity domain
> implementation. No intentional functional changes.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>



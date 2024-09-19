Return-Path: <linux-kernel+bounces-333806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EC697CE58
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 21:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A161F239B1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AC413A878;
	Thu, 19 Sep 2024 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uq/pZWWV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3145139CFE
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726775937; cv=none; b=WYHM3Zs9UlD2sUNlF8t5O2njaJWWKeSmPqCPhGxNuS93SY0nvsDU5AkzlUmzRCRfAdgNFYO4vTJChQvPQEFbsSrt52vOQnVBV77OUp80AY/s3f6CS2ubACCJQoBjR0x7uT3tML64tctwqPE2R2giHGsiTBt7he2bOPEj5n2t0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726775937; c=relaxed/simple;
	bh=LS7GkpmgUUdA1yoEbHbxbJFO3tiZMC+glZfVX6Vn7FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtSWVouNTL79MiJKx/tTXLopblLmNz9wXshQmUVaE+953UL920l1zK4ZKXS0pt6jxj6X3aXMq0Mbav+dWarsi/NH0iWWVmVOmaJSXHnulB0Rl+JsQiRnr1fL3o69RzxLh/oakr0wxFJKVjXT16okg0OnCt7Vcw6ywEcLdfo6rp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uq/pZWWV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726775934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uw3K7ykFF44drs9NAs+jCzR3haQI1c688j5wvgISOu4=;
	b=Uq/pZWWVktxGRVFLydO2vC6Hct+3r4jSLXd5s99pQ4HdVrClrdQl3tNw25lj/I8iwfM2PN
	7FtdvxFU8/fPizX7OrnAt1v7oDQrih1704eQQKoQI7eUu/k6UDXpnT/skeeD9FbNxPGxDX
	1SoyiiLcZ9+ia9sxxTM4tQZs9WM45Xk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-foarJzyrNd-lQ7Eald1zFQ-1; Thu, 19 Sep 2024 15:58:53 -0400
X-MC-Unique: foarJzyrNd-lQ7Eald1zFQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6507e2f0615so1130357a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 12:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726775932; x=1727380732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uw3K7ykFF44drs9NAs+jCzR3haQI1c688j5wvgISOu4=;
        b=n6kh9Xcx17MgFLJDCkLSF0u3ZIaLtpAZ3ssrAgzVCRYOCzZDBV7BZmV3mN0cqoDNRv
         AdKMg3RYi9ir8FFlybgqbgBBAl5FGur5S0moDP8wQ1rqq51t+crMdmI5kBe31vKFkag3
         4vz4xOq5PrUrhpPwPevX7yPybBe+hwPxk+lfJPxVAX4hNT9Xn6zxiXwg4sqempvTlg/Y
         nmb3G8JTinV1JxJPuU4DZ9d41ObtxDFO6VnQQt/fricXKD0EGhIcFSWH3CavTU5RTNy6
         OcPOBlAtvt9905KnBSPDMb0ewB0wYfKZChI2Ib8amYfJX5hMpLm8w6wOhPLgRKY59nrV
         bG1w==
X-Forwarded-Encrypted: i=1; AJvYcCW3dE6MckyBHLxdxrqXNFivUlTaXNmmj1WqNJhclrljVBAkWGpGWjC1NQCQZQyFnwbfA+eCDz7NAob4BOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZCPaYzN4+aC4UjG62RYbMhvpKgYbpA72R9+18jDREVh5pR8g6
	fJAA2iQ8uaaE+4P05D4S3gJwG4dEcMDQiTI9D5kf2GLg1Kyc5p/nnhq1nhuGepuSco9LHz1u+45
	8ghp/IIyizTtLNI8Qj7fdPLhDsUcv64iKWtkbvDJrT3wS3En7XH1bo4l/QMxkXQ==
X-Received: by 2002:a05:6a21:3984:b0:1cf:5643:459a with SMTP id adf61e73a8af0-1d30cb6ad31mr234154637.43.1726775932255;
        Thu, 19 Sep 2024 12:58:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQb6DGtXAS0Y/S6hSYcohhBKcUqxpou8n8QoeC+t6JtE14DWnS9KfuoX0HP7jy3GAxCNx1eQ==
X-Received: by 2002:a05:6a21:3984:b0:1cf:5643:459a with SMTP id adf61e73a8af0-1d30cb6ad31mr234135637.43.1726775931965;
        Thu, 19 Sep 2024 12:58:51 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b9ab85sm8950434b3a.173.2024.09.19.12.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 12:58:51 -0700 (PDT)
Date: Thu, 19 Sep 2024 15:58:42 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH] pm: cpupower: Clean up bindings gitignore
Message-ID: <ZuyCcs67swgQpryP@rhfedora>
References: <20240919180102.20675-1-jwyatt@redhat.com>
 <272b9839-f2a0-4090-be41-cf0ff8721808@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <272b9839-f2a0-4090-be41-cf0ff8721808@linuxfoundation.org>

On Thu, Sep 19, 2024 at 12:39:01PM -0600, Shuah Khan wrote:
> On 9/19/24 12:01, John B. Wyatt IV wrote:
> > * Add SPDX identifier to the gitignore
> > * Remove the comment and .i file since it was removed in another patch
> > and therefore no longer needed.
> 
> Don't use the * in the changelogs. There is no need to write this like a
> itemized list. Simply write it as a paragraph.

Sorry about that; v2 sent.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat



Return-Path: <linux-kernel+bounces-558350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF578A5E4A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244CB17B250
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D799C258CCB;
	Wed, 12 Mar 2025 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDilVDFu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E861BD9DD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808495; cv=none; b=O0DbF0LDlg9Lhl3AoaSQ9j38lyrF+binGkfgavE7RyeRZNjTngbd78HdR6/WSqDf3Ww31Gwi1AfzgITZwpVb6lCervtG6VkLhx5Heagbk1wi+gWr74DOOtIcf8qZML5f0594hNcCD6pYQj7gMvI4f2xEWos3Dcx17N9p5BJoH9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808495; c=relaxed/simple;
	bh=chqaRTqy0/9wIACLkVCZlXVspE39+hFf13nQroISW9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdCJUHQXaHy66Cuk0gJUlSuLzvqUAGOz21Mn1FtLwcIWvzXDmfAJMkNeSl8n6LiAb31GvGym7bdqZne4yTrsBb6RdZIVRyBwZ0rtObE0+JzN2XPx9RxzLT1v6QgUns9CzNSHlOld+3vi3cxKu30yLKIGlvU3i2h5rh5DoYkuBkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDilVDFu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741808486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=chqaRTqy0/9wIACLkVCZlXVspE39+hFf13nQroISW9Q=;
	b=UDilVDFuzbMNKzhUWXas3HbaR9sr4LOyRc3bljAjR7IBmkvYk5viTB2FaLaTXL8I2LvP8G
	Z8c2OMvA5QvQs9qMh3XQq+bFT+MdokIjAARIrVl8Iul06R21rzAoz5SdqJmbXLVdPc+DfW
	7mIi9zKN4WriJpuU+b9hDvMeZlTG2ms=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-Eh6T5tWDMBiZlsaCD7KXlQ-1; Wed, 12 Mar 2025 15:40:43 -0400
X-MC-Unique: Eh6T5tWDMBiZlsaCD7KXlQ-1
X-Mimecast-MFC-AGG-ID: Eh6T5tWDMBiZlsaCD7KXlQ_1741808438
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c3b53373f7so35212985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741808438; x=1742413238;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chqaRTqy0/9wIACLkVCZlXVspE39+hFf13nQroISW9Q=;
        b=kCrTjMQr67z/re7nMB2JIP8EcU7GPSadh52mcmfYYx63XEcJZ/+Z5IwbpzU7UHMW/g
         fGKKxRkAhxJ1/9WSbKfETd+kF8f5j4AG7khtA69wz/RoYYeiguNskxEOHh9xRboq8xmO
         Ni+tJ7GM3aFfdLxQLXw8LvtLwXHKnnpPMuPfdqKU4JGYmk4+HvBNnCBy88Uo9S/kdWEH
         6aa5ulvC0JLPPcF15musjt6FBfDMKF0RzIHKEXHB8WkzVLZWg2UZYVqjkKImZRSnCoAf
         L8X1T+ptLNM4QGBSFYxcmtaNcAtvAT84W+UjTGN1w/pRslLT3+nhk/R5ks+PN2UrPbLS
         /O5w==
X-Forwarded-Encrypted: i=1; AJvYcCWOWp9VG7tnUrVeWCWZfzqSjhn8uTEkKhcopIw7amQsccjKJhA1a6Q7k6ac5w455+5OSBomKR8XhUgf2Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMoAu4yNE4lgZdJ/c8C4aaT15v4GrV1DMXgXcI8+YibwtEcAlb
	pxrJvD9kcDDkmZgmAZFw6FVBRqhBDUvQlWfT31kwCUkA5jgiPX6Yp3JAT+TzfkCzukwvAcuRsZB
	BoHt97YapKrH86yNhRlmGi4Ygnn7FVkMnjZFDAsY/kjZhVC67+qV/c/5JnOwHLA==
X-Gm-Gg: ASbGncthByzqkHq2d1cbGlHFSVFaiBrId6O0Q6+tn/A4ZH9Vz980ylqn6DSfmHLJ3uf
	ICoOpr1kspc7zJnGDhcWczLU2rK5caiwlOnglm8d4tu5SDifNcobJ1B8A09AZcIrhA3BztbmDQ+
	Zyq5dqXX9Fa/MxQQaW3QLz06ghgBiZ+wJgPcrKkCElQvD34F5gK9dFaYwgJTHJnP+RJdNIBdltI
	3cfaPJx0Um659+ynhVIVr4dz/MHTa6+wtzeQoQ2KVCv9ZJXaaCa4NgSL530mTfluAKvIrse24TH
	uccFMtnWLWLvcPx5NBB89Cp2hKUML3rbbrJ4yGk=
X-Received: by 2002:a05:620a:271c:b0:7c5:544e:2ccf with SMTP id af79cd13be357-7c5544e2e11mr1931051185a.57.1741808438026;
        Wed, 12 Mar 2025 12:40:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFtjXSl18V3cVDW3uvVcF7AOwZPDm8P35ziMG/2MMADWgaMpNEr9E4j/T7ipIz220mu+4PBA==
X-Received: by 2002:a05:620a:271c:b0:7c5:544e:2ccf with SMTP id af79cd13be357-7c5544e2e11mr1931048685a.57.1741808437783;
        Wed, 12 Mar 2025 12:40:37 -0700 (PDT)
Received: from x1 (c-98-219-206-88.hsd1.pa.comcast.net. [98.219.206.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5568480d8sm476215785a.91.2025.03.12.12.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:40:36 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:40:35 -0400
From: Brian Masney <bmasney@redhat.com>
To: Christopher Obbard <christopher.obbard@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm interconnects as
 built-in
Message-ID: <Z9HjMyjzE9XlqrEj@x1>
References: <20250311-wip-obbardc-qcom-defconfig-interconnects-builtin-v1-1-675b6bc57176@linaro.org>
 <CACr-zFC=mPNeeHMp9XnSby+cMQaPWt_3s8iUiCN+EnVPeGad8Q@mail.gmail.com>
 <uljqxwfgl26txrfqvkvzzpj6qurgmwcbuot7gu2u6rwjaqgncb@jeuyi4mexjff>
 <CACr-zFDSFizYmrVN-dV334n1kq17UB9k4FxrV20NNQCQMhzrwg@mail.gmail.com>
 <92dd35a2-d1cc-4f2b-b3a8-5752ec33b0d3@kernel.org>
 <CACr-zFCYWEFPO8yExp_8hOQdVtC9Zwu1ZOZNksSeyyS6Ht0e9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACr-zFCYWEFPO8yExp_8hOQdVtC9Zwu1ZOZNksSeyyS6Ht0e9A@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Christopher,

On Wed, Mar 12, 2025 at 12:10:56PM +0100, Christopher Obbard wrote:
> For reference, I am working on updating initramfs generation tools in
> Debian/Fedora to include the required interconnect modules. Currently
> the interconnect drivers are built as modules in these distros, but
> are not included in the initrd. That is where my confusion initially
> stemmed from.

From a Fedora and centos-stream-9/10 perspective, we have dracut
updated so that the interconnect modules are included in the initramfs
by default.

https://github.com/dracutdevs/dracut/blob/master/modules.d/90kernel-modules/module-setup.sh#L74

Let me know if you are seeing a specific issue with the initramfs on
Fedora and I can help you.

We also configured all of the QC pinctrl drivers to be modules in
Fedora, and this causes a large number of probe deferrals on boot up.
One of the boots I measured was about a half second:

https://lore.kernel.org/linux-embedded/Z6J3WpeJKIKENC81@x13s/

Everything eventually loads and works as expected though. The upstream
defconfig configures most of the pinctrl drivers to be built in for
Qualcomm.

Brian



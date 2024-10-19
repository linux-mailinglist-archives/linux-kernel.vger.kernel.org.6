Return-Path: <linux-kernel+bounces-372587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BBE9A4ABE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 02:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DC61B21FAA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 00:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1301990A2;
	Sat, 19 Oct 2024 00:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4CMuT6S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9CA20E31C
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 00:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729298932; cv=none; b=D18Ji8bGiv7khx6RAqmVLB9J3+dlX15NOqtLLS6cZuZ4SxrZ+hiYLlw/XCZ0C29MToWtGmAeaK7DARKzF4nizDGgLiwj9wQO1ZjPFFnnQiOFAVajydHTjUmi5A4Xof6NfVq+if5V43pkgro+4cnOu5jkKJkcOta/SEfiToqPbhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729298932; c=relaxed/simple;
	bh=zxy6CVaPGBT/4hy8i0ysqF5Vh5/hv0JzciEqXjlH0T8=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=GYQDRwvmNY3wFCwKHNUunpBoSMwvgvtYydgRop5wayPTZnLCR4W3F0NHsnL4Ck9oNP4SqzYmXSkBw4FAYH5RY9UUDQ1IeDWoEVfhgW8pRaJBAHMju39rjOwtkild5G+axUDJY3SlnDsj6os3XMi7gHQKl1Rw27vAoKtp+P87Gmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4CMuT6S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729298929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JgCLbnQyx/xtWKFjluiXxC49uB//JvT7pDOfovgSmM0=;
	b=e4CMuT6SKFZkQVAcgtQIjGO+b7I4qNWeyMPAgFW6ndAsBeIFh91AQEpbp5xamuxxAaRVP8
	5OgW38jCfl/uhm577ioXnTxgslZQofwgl2Xc6ADpirt9/4MdLGs8SnRFkCOLAszUAAjqYM
	qrKxoL4U8qap4CvCKhQnTkmheLfB8jU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-A_jDSBasNhWkaG2f6miJLA-1; Fri, 18 Oct 2024 20:48:47 -0400
X-MC-Unique: A_jDSBasNhWkaG2f6miJLA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b14cb9f6f5so531765485a.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729298927; x=1729903727;
        h=content-transfer-encoding:mime-version:user-agent:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgCLbnQyx/xtWKFjluiXxC49uB//JvT7pDOfovgSmM0=;
        b=NWDnVbvzMWrumuymf0EZefMckIQg86Q3XD5x5yizXONLEPE5HMbyuuRPiiJMbvovKL
         bbOCYlPw6kKdsfqJbfTawrVTagPSz+s/U+8vA4U/gHimi05F8ey+/Gis9pyTvBXUxNHE
         UZ48EDunlGW4U5ff5nCUgadLa8TWNo/gB2xp2d1Go1JkH2ESBLeve5844S0Y3S0Du/d0
         oQHyUwLHSJPQscrQYscbHWZ8/PXzli5Z3E9bEV/Un3rr90eVRvJ94j3h34oFs+vlyCWF
         BW8XhnK7W3xFDVzg2XVk6RDSmaU84TcF1+M4Xf3E8EUZpuwNf8wwhlUfYKRyUYanxP0F
         ZjVQ==
X-Gm-Message-State: AOJu0YwMHsQfK2hO92dIyfX+jPXglApj/x6o+Pt3Vw5Fz1Uuhv8q7ZEj
	U3ROQd0poqrJtMnNyKyX21fy5HSF1o2raMgLL8rzxeSZeZ/wdUgjtJMSR7kAws1lrKHKPEjzX4W
	BULF1k2xUPF8QqCnNPs8Z+RY2JeiW7dc23zEGt3DZs0tINnuCo86ExTCSfBz2PQ==
X-Received: by 2002:a05:620a:4003:b0:7b1:168f:52f5 with SMTP id af79cd13be357-7b157c08dffmr432594885a.57.1729298927391;
        Fri, 18 Oct 2024 17:48:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbE+fH5q/tzPt4fAPBab7mipkiwt2i+4EmfiwvNgIQgqm7/iIcs96vJqnUL1fCVgCWkk0D4Q==
X-Received: by 2002:a05:620a:4003:b0:7b1:168f:52f5 with SMTP id af79cd13be357-7b157c08dffmr432593685a.57.1729298927022;
        Fri, 18 Oct 2024 17:48:47 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:760d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b156f9509fsm117950685a.30.2024.10.18.17.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 17:48:46 -0700 (PDT)
Message-ID: <c9d8269bff69f6359731d758e3b1135dedd7cc61.camel@redhat.com>
Subject: vmx_pmu_caps_test fails on Skylake based CPUS due to read only LBRs
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Date: Fri, 18 Oct 2024 20:48:45 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi,

Our CI found another issue, this time with vmx_pmu_caps_test.

On 'Intel(R) Xeon(R) Gold 6328HL CPU' I see that all LBR msrs (from/to and TOS),
are always read only - even when LBR is disabled - once I disable the feature in DEBUG_CTL,
all LBR msrs reset to 0, and you can't change their value manually.
Freeze LBRS on PMI seems not to affect this behavior.

I don't know if this is how the hardware is supposed to work (Intel's manual doesn't mention anything about this), 
or if it is something platform specific, because this system also was found to have LBRs enabled 
(IA32_DEBUGCTL.LBR == 1) after a fresh boot, as if BIOS left them enabled - I don't have an idea on why.

The problem is that vmx_pmu_caps_test writes 0 to LBR_TOS via KVM_SET_MSRS, and KVM actually passes this write to
actual hardware msr (this is somewhat wierd), and since the MSR is not writable and silently drops writes instead,
once the test tries to read it, it gets some random value instead.

Any advice?

Best regards,
	Maxim Levitsky




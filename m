Return-Path: <linux-kernel+bounces-272596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7277945E8D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0D6283D59
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D345A1E4854;
	Fri,  2 Aug 2024 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pewwMBAh"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDCB1DAC4F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722604879; cv=none; b=Q4WUMBWEu5WjZPnd/7tbJIKHTCWG+qA3Y6+eGWwpOCP2vp3bwJ/2o9C9gK9JAT3KRtm8vh8s8ru0WpmYeOAWaKXArWqzD1rZB1g8mhZmBVUbzI93lYOmThAmfFu0uEsPSkJ04aaLm/kcCylEn5aOIys6OiSRFuntIaGUsmE87q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722604879; c=relaxed/simple;
	bh=VqWvJwzVuU6BW4ZoCdK14eQ01/hn29Uz9tS0RmOI9FQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=STHv7X4xVnAGz2c9emxGu2mP3yhOQrRMJbF9LjOeu59vWz8oJ+xQuXcfHibY0JWhYRO5XwMbZMn5TC/H9zq/dQDVja+rpXTPA/OMpSf6N4BDCFEb0NaX7dxwQ0M0LGQVMOjiTAYXbF8rY8QXtiQT/rDpQtC15eowf7TYO3Wcx6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pewwMBAh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0bebbbebeaso787943276.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 06:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722604877; x=1723209677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VqWvJwzVuU6BW4ZoCdK14eQ01/hn29Uz9tS0RmOI9FQ=;
        b=pewwMBAhXBK0IxscaK0f/8J4vA1vtJOM9cLcYfTmzuQHgizgHQZBZPoirbsnP6797/
         zQrVLRa4LiJFWZzdZwiM/8Yq5BLl0IuiniMnCwemCrUpH404XhRKr9VnUxnfZccd6PjZ
         zjeS3zNKkdzz1feK1vNEGB5chLNZQ4udXIfiwgWMCoBmAqppxcpdHSvHE7jDReHmqD/y
         RvbHxxw0iK31EHNnb2pZlqAUl33cDa0/SbsEePUmHkVaqTcaOQoySs7//3Ol+jt66hWo
         qykWw0y+XD+GgcigyapjFvfq1Mp2fSi2ooOvWECOaDELzaNA0FfFe9rWMQ061oqGy9k1
         9LFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722604877; x=1723209677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqWvJwzVuU6BW4ZoCdK14eQ01/hn29Uz9tS0RmOI9FQ=;
        b=C+SoqWk5ohDjF0awjHKXA3mlliAn5qwonpN9q+m51z3jCVKZ8L6kWdZv5LK/qw6zbB
         5YccCe90Q8PIrMcGlhFyE3m/8KSydx1J432yKbiGFYQu6OCLsnLq7Wux3OyvUObBiS2q
         iKHhpCn63KpICJr1MZAz/3batlufeaxmK/ARytktjJ5iQK6KVXDHE6DAi8yGbIPuoZI/
         pP0NBjm584KaFKGWmSagK+c/fjG/atYzucCgQJ6t/9wlf3tv6/ThadPTAMTgbCjUe5Oe
         oH0i7KjVeEU4Y/+ebrtcDOHHn3L3I6nwwIlJnji0y7zYs1HbsoOQMmeEY+vvW8Yhx2sG
         uvmg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ6av/edMIdKMMyN8shmJ3XG4BVWe3fq4CQAK9E2erblosnbyaTMmLr8GZvN4KYaaCSeV7WXGYV3mAO/zQY8B1TlQLGVJFiTvmlP/1
X-Gm-Message-State: AOJu0YyrV1f27S8DYaXdoqRbNrjaW4UvMMG81mDNjMV+MAAvmJMjbTuk
	8TlvmQUKyaOwRKNtqLgnvnq3Z55dSgZ0T2kHMlqckfsSzTFBMYxj5hLa4xlSauUrf+zFRVoqfxM
	/uw==
X-Google-Smtp-Source: AGHT+IHdRmcx0BA12mQFvBkaYKf4yeXN8VHL+lxgAUnC2ca1x+ewJOhgKPm1A6kYOopWXAceWjBrUMi5Ftc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:608d:bed3:6fa6:96ba])
 (user=glider job=sendgmr) by 2002:a5b:ec8:0:b0:e0b:b7e5:4570 with SMTP id
 3f1490d57ef6-e0bde483a53mr80169276.12.1722604876722; Fri, 02 Aug 2024
 06:21:16 -0700 (PDT)
Date: Fri,  2 Aug 2024 15:20:36 +0200
In-Reply-To: <20230606154628.95498-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230606154628.95498-1-itazur@amazon.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802132036.914457-1-glider@google.com>
Subject: Re: [PATCH v2] docs: KVM: Fix register ID of SPSR_FIQ
From: Alexander Potapenko <glider@google.com>
To: itazur@amazon.com
Cc: Dave.Martin@arm.com, corbet@lwn.net, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, marc.zyngier@arm.com, 
	pbonzini@redhat.com, zulinx86@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi folks,

I also came across this inconsistency in the docs. What happened to the patch in question?


Return-Path: <linux-kernel+bounces-440128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6C69EB93B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A90A188A220
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA7F2046B9;
	Tue, 10 Dec 2024 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pe7xxDAr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5732204692
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733854965; cv=none; b=awknMTBhz/pbInNuNIQLlJOdHyHSuGeKjZ7MuN5jXVP6PHDCqbA2Q0WOqVZv5MnQ52Sw2IaDk2sxZCa9p8ZW+tSSycCo/iOy26VO7/g/jCfOHZVK6lbv2YgbkWcSZgc2+Ljywouhc8rTeN6UkA9q2vKbbIt2yT0Sxu87K+QN+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733854965; c=relaxed/simple;
	bh=1pHfdGZ8TK0Gn1cA1yV/fONw8m+PMIvPeERxVbGEHKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbZlzypGEZ1NJxSlOMg5lTJMlLSn4iVDif410OBQq5zXAdF1Tu/a5bEzwsqNx9Dtp3LcjYOCoBnujfFq7p78NsugQHzEXxW1W6slCcToI8W9kGdT9UxkGyDtIdYjy9Z3Nk+F3Yd0Do3ibNyvWCNJWUVEml3hbMXllpMHMWFVlPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pe7xxDAr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733854962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOADznZ6shRkxpA6k9z+HUBrSDKj4HgVFQ54YvYLX9M=;
	b=Pe7xxDArcDojh6IVvvqU2+FII1ftLaZBOYbQ6mu71vr1/GN7BHQC2TbmLVsPzDVbVZXSYl
	/LtFrBhSmXFr6jlOjBY4t2LXTSWiIRnl0F9WfAWRLxE/5DjKvH+4h5gSHEYjk7Bu8cm9ZC
	wAHc1YEOLhU35OQZNGG5AzJMNu0YP0A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-dEp1ZCadNeOK-3dkLpex7g-1; Tue, 10 Dec 2024 13:22:41 -0500
X-MC-Unique: dEp1ZCadNeOK-3dkLpex7g-1
X-Mimecast-MFC-AGG-ID: dEp1ZCadNeOK-3dkLpex7g
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434f852cb35so15565735e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733854960; x=1734459760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOADznZ6shRkxpA6k9z+HUBrSDKj4HgVFQ54YvYLX9M=;
        b=mituMHLzl/GBx38qZ2QgPnmrBzzzBwF/bvZ8bOvOrKS/vgMMs03anJKoZcMMbF00Ga
         xhpS2EKK07S+OUpfUS9dkggLJXJCL326wWpzzMSw0xn4v70qWYnWfOxdFsBJG7fBpN/J
         5eQbBlhog3TxI5Ei30FfNBDzIakCKoOgCggrTpVfHbihQmfi2OXqViFUT9u+KHfh/kLZ
         tqdwd4hdcTeJPvon4gGBHDIyKcIydQ2C1e1S1WUYOEdTC5yCLjAL9iOLzC05/NxTu6Sh
         zuDORe+Cdjog2s+ZjLUSbKUlxLdXx1advxemNz40skFRCAJJwmb7WMCTuEPBzlJXevAq
         YoCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfhT0XfS8vfpE/WUwr222R8u8UD6F8czlHR0jzXC+BZBRkap5ngZSZYuLDSNxHgREGDs3J2FQCI45OQTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnzwPoXZmsgZu07quIMq/+wX1Frnj4TELqId8OvCN2Nwp7YAO7
	X/UWrG//KzdYU8I2JCt5oeGw0ibhBFaSOPxEHvx+c3rmSS4BeNED4kZgqr3lKVEidqRefhzNmpj
	h0+5wo9RZNLwk+GyVoYs+JQBXFzX8097j5Jl8ezm/Riux3kWQyB8fbZYd+L9cDA==
X-Gm-Gg: ASbGncsX0HCPVQ654OyWOYV2hL1fvP5lIAOOT7DAMIZY3nZzhi3CfKKuqT1tI70o1PB
	WIXuBIo8Z3azuGrJG/xlZindHhyW9RLKrkmL59Zoa3duTAxPa7gxHhUCL5GXA9jVlD9IloQIvLH
	L58o5Y+AYAmin+elnRuVPILYHU1bpTIwiSuz1rXfx6AWzeBpfTGpi2DCgb0RdSb9pCIZGpdixUN
	r/YUdaOo2QuA4gRz1MXRLxklNtAFfw1Um8gO1HnVc2QQhsfSMI/0fwC
X-Received: by 2002:a05:6000:2805:b0:385:e3c5:61ae with SMTP id ffacd0b85a97d-3864cea5716mr78557f8f.31.1733854960351;
        Tue, 10 Dec 2024 10:22:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHA80j/yrBcVlJPBL9NjcvqMe2Tjew3KpXlix2cTpx5h1/Gz71wdXKtYr6Szqo6cSyw10sEYg==
X-Received: by 2002:a05:6000:2805:b0:385:e3c5:61ae with SMTP id ffacd0b85a97d-3864cea5716mr78540f8f.31.1733854960024;
        Tue, 10 Dec 2024 10:22:40 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38634bb1669sm11209482f8f.60.2024.12.10.10.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 10:22:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	yan.y.zhao@intel.com,
	isaku.yamahata@gmail.com,
	kai.huang@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tony.lindgren@linux.intel.com,
	xiaoyao.li@intel.com,
	reinette.chatre@intel.com
Subject: Re: [PATCH v2 00/25] TDX vCPU/VM creation
Date: Tue, 10 Dec 2024 19:22:28 +0100
Message-ID: <20241210182227.251848-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241030190039.77971-1-rick.p.edgecombe@intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Applied to kvm-coco-queue, thanks.  Tomorrow I will go through the
changes and review.

Paolo



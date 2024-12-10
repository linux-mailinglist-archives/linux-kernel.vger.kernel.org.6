Return-Path: <linux-kernel+bounces-440129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4B49EB93E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4A41889E09
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7AE2046BB;
	Tue, 10 Dec 2024 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3BfPAVf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF89986357
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855029; cv=none; b=Mook8682O1N1UM9CNdNqBja9QGj8mTNOIrskJdIgXGUz5Rw8EICHfUUC9rLmSJrvKPxmpJi7VMSBwY95iWf3G6jj6uQ6lH6iTcnVCePY0GY97pt05rYc1TcRcNQ8v0wOJUo0FyEuewROuKoSDdKvXa5nUEjOiDrT53ZJjQACFDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855029; c=relaxed/simple;
	bh=7nhMPj/ozuoD9sVD9Ow1ZB9+eVVLEWg/CeyeINkPCXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=su17q7vta0FkLuVICigRb5BoTQ0f2qXRCKLhowTRNLBxW3KCv+e4CK0yHRUD93LZO1FVF9nMDdIJkSXmw6TjJV/fJJmeTDLWQEpblzy49LV+gbSot/uUUO/i4o8momv+N4hvvcTHyH0UD1bcjNCRBQEIQ5Q0OuhyiDREUsP/FFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3BfPAVf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733855026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7nhMPj/ozuoD9sVD9Ow1ZB9+eVVLEWg/CeyeINkPCXM=;
	b=B3BfPAVfHeotfHg4s7PX2C2H3D8FMRuBbK+Lo9F/rTKHF1dgfZ0A88VyCs/MTnJiSNkKFX
	8aOJNRwOG7ILFcrNyAYpAP9y/3X1fwLYoJbX8uuhews0Qee8Yhp1AZLueCa/BaAKNn9P/x
	jDFqkL60Tj/2wyNx2+PsQFpq8E2tTNA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-8Uo0TkAJPYOcvVX7EHAltQ-1; Tue, 10 Dec 2024 13:23:45 -0500
X-MC-Unique: 8Uo0TkAJPYOcvVX7EHAltQ-1
X-Mimecast-MFC-AGG-ID: 8Uo0TkAJPYOcvVX7EHAltQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434f5b7b4a2so23105245e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733855024; x=1734459824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nhMPj/ozuoD9sVD9Ow1ZB9+eVVLEWg/CeyeINkPCXM=;
        b=AP9CwC4YpjtqsFmmTWdaeRKp/mS7TRMRc5yA0k6VqvHVlGwy6nDdxYLXytJNBsFPZk
         cyWAh3BrFJcYtOaZqKXfVPQzSfRtUBwvoeCMMyCL3Wxq/WbuS1xWsgDIB7JP8H0JsZ/2
         v4T1jx/0nVbytRIXsgaeD2SiSD53gDmUIe9L7FB13DnfJZ2IAKFrsyMonxKg5hPH+Ptl
         WrvZ4oWhOCiaY+SEJqg01heVESYkn158XEjRoBpphcBy4lsjjovWYtS/DT8xglTA7Qko
         FP3qMacPm0QqvVWwozzIBYQNUNRCdzBvjXUzkkZ0H2g+vC8h9mS0ynduu5hLpK0N6d4v
         A/OA==
X-Forwarded-Encrypted: i=1; AJvYcCVuyea0fMoLHZxSSbx6nqsVALx+kmMgCXhuGjZAhM02jg+TIbkOTeT0E2XXhUOTuihHDfq8geZPXnHKUb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWvZjdUCpe49EaHbZJxm15mnTPDFweKVJDRfbfQc3S2P48C7XH
	6OAJ1plk3KqtbBRu7qoYWdgSO6O7FhuvYwnvzrz5nYJlc+Rt0MQQsWikbN35lkXWlNp0EDKtyVL
	ja31E7f6ux4w1sJgvz2BJlPC7ZA/RoFGdemqfwIkCK6YMsksqtpOZxm8598CltQ==
X-Gm-Gg: ASbGncvevVGY9+7oxFgz3DHn0YC6wVLiFNsAySm1cWYgZdX2rdjwSTnT/Sl0kxEt4Bw
	Bbhw79YgUw6jyxn+oyfi67vwUcl3H5e7Kkg2Y0ubrsFatm/D+/zdAwu6qHbYaaPGso8xaI12wxm
	pAvpjWSMqP953bpu/E7Srm3eRj3ZUMt9Nqr5KC4IXmotmlOjOA+PgjUJJmBLTHUXg/F1lRUJKIL
	aTrViAXfKVAmBstN7+npwDYOUVFm8GO1TbyVUTXHj4zVWRR++hoYYVL
X-Received: by 2002:a05:600c:5101:b0:434:f739:7ce2 with SMTP id 5b1f17b1804b1-434fff3a13amr48639945e9.8.1733855024003;
        Tue, 10 Dec 2024 10:23:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcBUe4tQxr/sYMsPdsIGolKvRnl6iAq8l42fK6nd/vXtSaWTjeFoSgTyan+aE+KKg/tDvXjg==
X-Received: by 2002:a05:600c:5101:b0:434:f739:7ce2 with SMTP id 5b1f17b1804b1-434fff3a13amr48639715e9.8.1733855023643;
        Tue, 10 Dec 2024 10:23:43 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d26b0sm203807665e9.9.2024.12.10.10.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 10:23:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	kvm@vger.kernel.org,
	dave.hansen@linux.intel.com,
	rick.p.edgecombe@intel.com,
	kai.huang@intel.com,
	reinette.chatre@intel.com,
	xiaoyao.li@intel.com,
	tony.lindgren@linux.intel.com,
	binbin.wu@linux.intel.com,
	dmatlack@google.com,
	isaku.yamahata@intel.com,
	nik.borisov@suse.com,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	yan.y.zhao@intel.com,
	chao.gao@intel.com,
	weijiang.yang@intel.com
Subject: Re: [PATCH 0/7] KVM: TDX: TD vcpu enter/exit
Date: Tue, 10 Dec 2024 19:23:11 +0100
Message-ID: <20241210182309.251904-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241121201448.36170-1-adrian.hunter@intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Applied to kvm-coco-queue, thanks.

Paolo



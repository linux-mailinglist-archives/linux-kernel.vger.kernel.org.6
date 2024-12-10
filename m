Return-Path: <linux-kernel+bounces-440132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89E89EB945
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395F016596F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7E02046BE;
	Tue, 10 Dec 2024 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQD1UpUL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7A71850AF
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855072; cv=none; b=P8mhPuAiHQbI0DBHduMGXgKj/i963YRaV+9Zi3x1ALI6rgJTkq39OQyhQByXRnrjGGoixf48Dhvm04ruMdRwHZVWXfiqboLjTKTs2h1YHc6Ayh+B0soSY3J3MasiRhI596AGmle4H60Zo//H9rSV0afa3nrL6ZyRGR7VZE/hMaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855072; c=relaxed/simple;
	bh=7nhMPj/ozuoD9sVD9Ow1ZB9+eVVLEWg/CeyeINkPCXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHvsK92ishJEJk1sL5oyufhu383NPw0Mu7kzqpXI+vdqx54NqH295v5IuGqwAORW8vv7e+hFFxo3QKojbG4gdm6Mf4UBJVMmi4gMnVEkwkawkbUGUVLSI50bcAKVuD0fC3SiZ/9Un/x55V4+eNmMZL03BK7R3Cb/oGgrliat2yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQD1UpUL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733855070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7nhMPj/ozuoD9sVD9Ow1ZB9+eVVLEWg/CeyeINkPCXM=;
	b=hQD1UpULTwfDyvi7xGmhSj8Wh2IM5Sm28LlxJncFNLWjX5Q97CIQ07SL05XY+mUUqWdbAf
	s9hZsxj5XYZohR58cUno9zTdW1lSIZ4wP9QCGyacEERTS1HywLpPtI5bIkMIk/CglHOx4c
	Rf1WM0PTS0JQFxbBx3tzfuk0UT21dX0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-pKYp4utfPuyIGBr1h5JfVg-1; Tue, 10 Dec 2024 13:24:29 -0500
X-MC-Unique: pKYp4utfPuyIGBr1h5JfVg-1
X-Mimecast-MFC-AGG-ID: pKYp4utfPuyIGBr1h5JfVg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e9c698e7so2873125f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:24:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733855068; x=1734459868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nhMPj/ozuoD9sVD9Ow1ZB9+eVVLEWg/CeyeINkPCXM=;
        b=o1rKi9H1hFfGNM0jkKJ+DzPzzTD73Jet+2LQckIhqcjCfAxBIs+9vpzwdQJeOqFELm
         hZxtyKeh6VZ7baK32QFxoYf8JXbsXUHvhdm8MGD3tiZWNqUYG/pL1rACGR49eoPjIb3e
         MfnkDcVOAgIQ7iX/4gNQwd90UwlVzUuxmFo8WpKrlkoUaT3Aq2KY2eyNTbp87Ojt7Z0Y
         2hvWkU3NJF7dOc/23qKA5GhvP2P/uQdsva7q1tlsK0MgYCVeDF/IOVbsM+SBf2wNw82W
         2EIqqLChv+HMTHqW2YJg/e8XfH+AB2Lkf6zsCLGPjrSx8S9RX1SWhpRGkFoLj368jrPN
         rZTg==
X-Forwarded-Encrypted: i=1; AJvYcCVCM9I992gSvSETmInaJ+2D1tldfww7DLVJKQwsEGYBA0gt4me6shUpNrR7TufaeLJlKrt/SV+mJB7A6OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhA8dtY3iCtyfYVByuo+aYFegyTFb/fAS6sxuJKQtvruTvyb8G
	e8DeLW5HNblgrhWil3zc/VxZcPDgbo7MB8pUr3RR248stTm9gihrB42k/p67nJORjuoOFNRj8CK
	tXO3ajWRS77o3wpyQqcEZ5XKxTVIrO+XTac1hDNRsS76UOZ3J3YqXE+2s1La8Ow==
X-Gm-Gg: ASbGncum9A+jjzTAb7JAHzsu5nblawD0XdmO3aAk+GLhm6rJSCs5xkCq7r482bci/G/
	uV/+qnR5OV9ZJv3LU5lcRFmJcgkhHF2JeAcLVZsGkSKWm6Q/RCB02ds8+a/F8pDWGyXIzwAT3pl
	rCqr0Af0YLQduaPW/ckuu2+nC7w5Krw1g5LeKSsOkGydrXEDQXDzM4IFm683bTlrS8jwtXMh1Z0
	JGvgmNh4Mtgd55+a2kLcbWXv0f/zT+arc0TspJ5tEGaqOYD+o1BqvxO
X-Received: by 2002:a05:6000:4022:b0:386:3672:73e4 with SMTP id ffacd0b85a97d-386469e981amr3473955f8f.26.1733855068205;
        Tue, 10 Dec 2024 10:24:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHx26Gp55ua37c5IiyimVcDcoJIraGmY0UGD9XeA5hsX3pXEMqbHtCokBGh2VOcCbGG9W5FA==
X-Received: by 2002:a05:6000:4022:b0:386:3672:73e4 with SMTP id ffacd0b85a97d-386469e981amr3473943f8f.26.1733855067885;
        Tue, 10 Dec 2024 10:24:27 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526ac03sm241795075e9.4.2024.12.10.10.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 10:24:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com,
	kai.huang@intel.com,
	adrian.hunter@intel.com,
	reinette.chatre@intel.com,
	xiaoyao.li@intel.com,
	tony.lindgren@linux.intel.com,
	isaku.yamahata@intel.com,
	yan.y.zhao@intel.com,
	chao.gao@intel.com,
	michael.roth@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] KVM: TDX: TDX hypercalls may exit to userspace
Date: Tue, 10 Dec 2024 19:24:19 +0100
Message-ID: <20241210182418.251991-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241201035358.2193078-1-binbin.wu@linux.intel.com>
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



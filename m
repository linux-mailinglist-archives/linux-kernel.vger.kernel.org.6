Return-Path: <linux-kernel+bounces-355858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310CC995814
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09CD1F2179B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E29213EE7;
	Tue,  8 Oct 2024 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldiHwV8G"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573CF38DD6;
	Tue,  8 Oct 2024 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417848; cv=none; b=kV8xIrQdb8OgtvFK/1a3ooCWTAZKc2daQkcNTieoanf8moIYWS4Jmye5cOgh3bB/J0FGhxIFquhLoovWOdLYrXYMz77vbCNr+SIyXTNBGRwHmq3YGB5ItcmKOqFd7Z8lz2Yy811es4MCQK4hMaahUmLFns/xADJDSZ7SAN7j9kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417848; c=relaxed/simple;
	bh=hIDdguQllWlrrSrcWZPyuiCbjmKx458t7j7bTnzxdJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVQUdGl2Fjy+QMeM4vO9XGuqDEf/AWA/ebeuxTxE/HHyT6yqM5AFvecrPHj7VPEgEAPXP0lOU9ljJDL7ZK7dg2Hv9ddLPNulDrYZC8tab6Z/PjCXHPmjBP8CaZ7DguAAcYQ6ovWoO2JVjTFdILhetlrau7wsyIV/ibrHq7giMSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldiHwV8G; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b9b35c7c7so43379995ad.1;
        Tue, 08 Oct 2024 13:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728417846; x=1729022646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIDdguQllWlrrSrcWZPyuiCbjmKx458t7j7bTnzxdJk=;
        b=ldiHwV8GBDpu1TUgyJ7lcCSxeop0QeGU41jJ0msCZgMVEuRtVLlIWKXZiHJdUi8+z/
         +33wDNLsfA627GIs4+Yhj6s8AUOq2reGwuPuQEaOS3bXIcBW7CGP8VjzPaY3TLnbFwRA
         svioh6ONTS+uKeep/YebsUlkdL1LyxR9rEhoPvptwuRdErWRpMt3+ZLEvRn4nD7QNgYE
         gMDb+XwcyToOYxbVkkkbdGZEKJbVTbcUvY2CiMqD5Y+2Iy/gpjoIGYvS2iRxFVH6Eexf
         a7KA9+0jbXspe0y5DjbDYWbi5OOyVbxSb11OFswrxSSVWdpbmlXQRYuuQM//JpXd6v9O
         /6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728417846; x=1729022646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIDdguQllWlrrSrcWZPyuiCbjmKx458t7j7bTnzxdJk=;
        b=BGA+En+cFdXYp0UiAO36zU0wE4T9lEJiMDDpvvzb0OC6t+kZS2Led4Y0sH+jrIe4cL
         w/l4eB7m33yjZI+YCZ4Y9rBYvINbgYTbcxzDFDxfv3ORqpGdcty66I/6UTN0FK/rH19x
         cMxdVVbBcmLH5LM+08SNmVGt1vsPtM7/hml1d9ll2Md9eaF2tluf7MyuIYeUMkS4HEEw
         D4w+JyCEkRiiAmK/P/3MoUrFWuaAQDHRJrRg2934YXyrT3tH/vs/CRNsso8hT9xz1xLL
         3z+PkG9ITv86pN2T2jhBI5S19m0rF54IoXyiarYhM2glp+DPYSF7McwTN+/NGD2Sdf2d
         cItg==
X-Forwarded-Encrypted: i=1; AJvYcCUgr7+jHRb0o1CZBfUYwQl43ctXxN5FPKio+e/HDuGBRxLEORPMz05JOsvzVkEfolYqHGbS3wJbe1Aur1I=@vger.kernel.org, AJvYcCV7j3z0ajGFTuuDnQD2pn9q8uVcnNgNRSr2EOiuvukBc+HsGLqblKaCDtxw+M3R7MdwnK2PKLD3Uqe0aZc3Et+3lxa4vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZRUA4O9PCqbWEt+EDWTW1yY9/SO8qgGG9qXBBR//xH/kM/qGz
	eKiTu42r3vRY5hsTKM76/hfUKspTB61PjlXLv7DdP9qs3fCy/ke0
X-Google-Smtp-Source: AGHT+IEtJsd+K+WN9pJ9nP4sHlGi1tJMSZ/1lsCBtLZkBRPv+JKjmD2xW+j6mmWfLDYRkPkMKZDeQQ==
X-Received: by 2002:a17:902:db03:b0:20c:56b8:1627 with SMTP id d9443c01a7336-20c63787f1emr2390245ad.35.1728417846470;
        Tue, 08 Oct 2024 13:04:06 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138d05casm59011765ad.91.2024.10.08.13.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 13:04:06 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] alienware-wmi: Dell AWCC platform_profile support
Date: Tue,  8 Oct 2024 17:04:03 -0300
Message-ID: <20241008200403.37798-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008193746.35318-3-kuurtb@gmail.com>
References: <20241008193746.35318-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry. Please ignore.


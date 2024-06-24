Return-Path: <linux-kernel+bounces-227813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 404D89156C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B691F24396
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9E71A01B5;
	Mon, 24 Jun 2024 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F67vwnOC"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC3F19FA8C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255363; cv=none; b=org2Zu6VwFlP/fck/eWoQNLoVf8fcGxx9/SLxWbH8A+69G50uxPbizW3RS66smhOUVZQO9PxZu/dhlUwbcTI6TC+hnvm9dtZX2T7p6K650i1UeHJ7D8z2dsIvb6pEt+GbLQ8BPlGJ4RxoLNFTj8DUC9PKroWkUJAhnNtM5793/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255363; c=relaxed/simple;
	bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=IpB6n+fSMktHhPjTG2Ma+rZ+CyeiVofYCBze81p3w3wgMv3hIEwHKtMWtUbY6EIBA54zRDFcdofkO41StsBdYiPhsWoDzzye4tgdw2rw6V/4PRPYg5fYfalOTfPXJ77nA6QrvL/gneMdkOzSc4XdHzQtTbWZRXvSPLNmYj29lXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F67vwnOC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-706738c209bso1178647b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719255361; x=1719860161; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
        b=F67vwnOC1S9WtRfup6s1AIaif5PseAi2nHSVwH/1AeS7oQWdQNJNYxa14J0PjSK1yE
         op9KRsjPuCe4A+uDpoQrwgK5BRnP85l3OipbbM/4FY77bgBVSF7WYYZumjULHVNCweo9
         hlAGDq6qhqJBnPa85c4rh7b0xAJHGlaaihydkyXbSUBULwrUID4OLh+fal8AlW29g18R
         i+GQQYqdZwy533xS5/uekEvjEId1OGn+6FIxZoZAnIwUemTIwgcSCAdM459yuMiNlioZ
         iwODXF8AzR3BQ8PvQm+LHkXR7iOPRcoE+j6s89F//G8E98gvF+mPU9IkReyFrqKcnKwP
         MdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719255361; x=1719860161;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
        b=sjZXDnnAy7ZOo+QbXqxtFq9ob5HTrYox50H/IeU3m9YOv864IszgdSlWW3VDcntmUF
         6Ke0ksVaJkABHRCc7fnX1sOR1ZEiJ8yUzg7YntTZcjadKy4ue/+3UXoHQ9Z5YCn592ql
         b1FbMY5Enpe75cMwb8ct5umuCWKNTHmlKI7XWfuEzGN0X5eg65m2b3HExDKMezXsyrSL
         fzApyYAXBPGXAmEESCTN+VSVO+Tg8a24xSW9YSRDLcA5ZfsX014MYxsgYkIOwUuL017t
         oWSB05A89vaXuQNKJL+Opz8cygsnQvX2jhUQKIrwlhfX7ll/N5NRjkIWIlQxV5JrJ8kr
         wMSA==
X-Gm-Message-State: AOJu0YwaGwCmOolS0pzBg6/6hxTGvrcNRsunl75ff7Ra7gAKQR4wJfZX
	LKyu7kC82tcc/VC+B6+oPvZXEmAeRtKeoiiGmMSQxQ+VtTwgNIq3aNiEkQ==
X-Google-Smtp-Source: AGHT+IGYalnPHUVMqv/pagXp6RELk6Kw7osCnBmezMafC8tR67DvOYT1u0dfUFQ6Ki+J0p/XIXm0tA==
X-Received: by 2002:a05:6a20:da9c:b0:1b8:4107:ce4f with SMTP id adf61e73a8af0-1bcf7fcb609mr5409043637.49.1719255360795;
        Mon, 24 Jun 2024 11:56:00 -0700 (PDT)
Received: from smtpclient.apple ([162.220.44.18])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716ba5b5f58sm5839782a12.73.2024.06.24.11.55.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2024 11:56:00 -0700 (PDT)
From: Soohoon Lee <soohoon@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: subscribe linux-kernel
Message-Id: <3F4D3DAA-8E9F-4C68-9137-5F2EC8721974@gmail.com>
Date: Mon, 24 Jun 2024 14:55:50 -0400
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3774.600.62)

subscribe linux-kernel


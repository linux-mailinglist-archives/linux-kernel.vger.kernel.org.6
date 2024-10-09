Return-Path: <linux-kernel+bounces-356808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5D299670A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B81A28A3F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5C518E744;
	Wed,  9 Oct 2024 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDl0jzCw"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA4018E030
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469333; cv=none; b=snnRqiPRKGnxjCBS7jHFtQw7c99Nj71q8jKg91LKHll41ErmgEvf8mSD20AVo31kwZLBZliuhg/pXhWgaFJetQHYd2VjeqVmzPW7ELAU9zG1+pxjFRj08GZWWDsMEhcL4S9rfk3a2BIp5vCOJxEugHRIAkxcs4k5iLE/jGSANdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469333; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Content-Type:From:To:Subject:Message-ID:Date:MIME-Version; b=AXJxUGlIqDyEBF2wiz0wBAZSTxPNs/ORV+FZvAt9QYuX9RAKzbMfg073WHktutk1Hhe7UQ99wCFwpAKS7Se5i1b15OMCelqvznB8PRMjt83neRcfkwhgVZVyCT3/mcu2hm7tiDL/zFARCpKjyxu166ICJL53Q2bH4iELLnhw9gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDl0jzCw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4311420b675so1816005e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 03:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728469330; x=1729074130; darn=vger.kernel.org;
        h=mime-version:date:message-id:subject:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=ZDl0jzCwDylEbtgtrnoZ1OpB6OGACxD/jGvt7z4gNS4QlAE4QHABFuFbh/qJ3lwbqt
         yTsBIU8w5PRA0swcK5f4slq/7uP9ybjI+PVKKYw82jRO72xjEUGvbrY2S0Gw7Z715yJg
         3f/v83NFh3yPsO5dq468N42wrYTsvrLAmGgbTi0FVgGr0F3PNRCElcKKfVGbKErEt2CN
         SIcj9WPB/RzpwQdXMPcumDUJc1CIgbOE+31/jY7+KMlKjteffc5IZrjr11S+SazyPyWz
         DeeOAOesvNvLrvzAyyn71dltvW8oKB2HD2E95V5WiIvUoT0XOUMM7B7BNDbUgvDF6FLT
         Dw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728469330; x=1729074130;
        h=mime-version:date:message-id:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Idj2IUmnKx6Xzrl3wfqDqEj6tFz4FbZlUaNd3yWazrwXmmkR1QMdJBOaes2vi/wfZr
         JP1QGKpqeHYQGrfZpe5K76sQqz2HbBVrBruCyJn0Zng58GgeAbvfCDYu/DDNeaEJc+VA
         zli0xfIpGU3exgMuF0FL2kmaSVlFLgSFtT/zyTFkFpanUMvJ0DODs9i9LD3jo6WQuMrs
         3vvAdhkgrV1ZOK6HoqDCgd9cdISV3OsaSNEEtIkjh3wWyBkLG3v7APS/ELL2UYj2Xj7a
         VpxqSQe59YkjYNg1mb34L8or2TIn8wtCztWSfF+bsdkt0UkZWKMiDTnfs4iatdbqvz/a
         YFYw==
X-Gm-Message-State: AOJu0YxQ0rr6IbT5mw5eb9rrmbPe9RRqCmzuygbR9itJNDlWZw2yh1gv
	fYVDH1rXEhkKvLTF2GKUHcPItEEHbPjE7PtCI/3EszGoh/VGgsOL6dg4n/JMiJc=
X-Google-Smtp-Source: AGHT+IFhivqCZ1zhtc0hXO8bH5FiTPc01csjrG6ODdmgapAgYkyrs3sstKmwy38OUy2inP59lJ+FEA==
X-Received: by 2002:a05:600c:4f48:b0:430:5356:ac8e with SMTP id 5b1f17b1804b1-430ccf02893mr15500975e9.5.1728469329826;
        Wed, 09 Oct 2024 03:22:09 -0700 (PDT)
Received: from [127.0.0.1] ([197.211.61.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf1f801sm15744465e9.9.2024.10.09.03.22.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 03:22:09 -0700 (PDT)
Sender: Regina <reginafemal224@gmail.com>
Content-Type: text/plain
From: Zahraa Abdul Rahman <vp12352154@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: hello
Message-ID: <740becf1-fef8-4490-e943-e97c1cd09183@gmail.com>
Date: Wed, 09 Oct 2024 10:22:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



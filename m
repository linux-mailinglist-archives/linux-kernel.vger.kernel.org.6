Return-Path: <linux-kernel+bounces-284762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828789504D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B464B21F21
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52D11991D8;
	Tue, 13 Aug 2024 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVhX8MQg"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD26A1991C2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551824; cv=none; b=JzTpXl9/dRLoebovmexH9hjWb0ypX031Sbg33ex/TzWQmC0o+XHsEpzrlsDb0fkD2lMhUZ5LeQejqnLK/BtPjuey7Iadanl4sua+PAQhhmifgYIhSbWIw3r53pmT7DfaomfTYLEIBqGowxWSC0hwwtOPOwVP7gzT1pNTljzENMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551824; c=relaxed/simple;
	bh=WZTDlEYLpP5SlGoHwxz3FYQ0xzY5TbtbsTj3mfUiuEU=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=ES3WhOHGPo18qA6bG+VYFM8zxr8SKv5BtoypJvUecPlIVTdS/yFDd/GywsXQ2nnAOzJWFXZp7jKPMOInzFsvr+njXzXuQVCMzrbKBLwjhTOHnj1vSNnFN34YAYim6Y/pR7v2OyB1WKc83NFc41hFxN0iSsMiPUUMYFL0NoHKBt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVhX8MQg; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39b3f65b387so22842295ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723551821; x=1724156621; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZTDlEYLpP5SlGoHwxz3FYQ0xzY5TbtbsTj3mfUiuEU=;
        b=jVhX8MQgJ9Q6wxlmiH4TRAvsaSMFJkdQZf24VIj+WN9hSQAzRkMXb90BL98gsyEaqo
         PzoOX8bZwJ6kUI2ltLexiAK69QZTAorLik9WgozgQbcq20PcLL/L3tjJoRT7FPIUdAD4
         Ky4LlamRI9o8ZIxwD+zAraxW6lMQIbZ5Uxw1AGbP7K1rOWNxARXKetAu+xh8yG7cOBCp
         YVdqKw0488bFRXEVqj7phy3FMP3YC48nNAPrW4LXts+6IZ6uv0tklvVq+H8dztHRaye3
         TnkUo95fgy190T4I5A4bK//L7TT/eL2Cmeost/q4YZR4IEf/G3UFOoSZBqbVCn9ynTGN
         ZydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723551821; x=1724156621;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZTDlEYLpP5SlGoHwxz3FYQ0xzY5TbtbsTj3mfUiuEU=;
        b=hR8zvBGGgCPb4vY5CyynuzosWd1wGjqVzh7lGEtXB35Wb4RhoON+X3IuFUgFfnKk9M
         tdDFVo0GdIF9lflCW3d4S4GZ7v9l2YgQVBq8JqBEWlQto9GXc2J0x47GTi5xkw9KO9v/
         jso8o2uOAYE2Pf5npohapDD8kxfUygTDxdEa+ZU10zWnrPj3ZQUXfLe2gWZoV+8OtpbY
         tECm4Zpag1SIqg5jC9XYhrJ46va1LL6gmDREcZVzp1VLhwAAumNDFFesQePxC/ZGKTBL
         cOehQiJ0lePoqxTpSmrBQyIAzhpP4EbUNqZ9pdrT+DTCANIqpKdzXto9WOB9gQ/Fh8Fc
         cfZQ==
X-Gm-Message-State: AOJu0YyyG1GfwrmozBuBIK8Nnjs4sewxQRJqZ9HtoApUu/RDD/2QG/9E
	cp7bISUnmxQp+LxRwyFx30THl9vJVSHeUsB7wSzJsBO/tZKj6pF8T2Ponw==
X-Google-Smtp-Source: AGHT+IFR4gx5yfWO9vn+bkhUh8I4Le9VtHs5nV5xZic/XwoBYc0rH84nIbDM2XW1+V39HI6+kDAjLA==
X-Received: by 2002:a05:6e02:198d:b0:39b:3205:6b93 with SMTP id e9e14a558f8ab-39c478d1076mr39567775ab.28.1723551821293;
        Tue, 13 Aug 2024 05:23:41 -0700 (PDT)
Received: from [77.221.149.109] ([77.221.149.109])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39c30a7e8c5sm24825695ab.18.2024.08.13.05.23.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2024 05:23:40 -0700 (PDT)
From: Steve Borden <carolynmays6735@gmail.com>
X-Google-Original-From: Steve Borden <info@rigga.org>
Message-ID: <231ac84364538733b07d8c862441f97d2931c939239b6df0cdb4b29b04ba875c@mx.google.com>
Reply-To: investmentsofficer@rigga.org
To: linux-kernel@vger.kernel.org
Subject: new project
Date: Tue, 13 Aug 2024 15:23:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

did you get our full corporate offer (FCO)? It was sent yesterday. Kindly confirm.


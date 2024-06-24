Return-Path: <linux-kernel+bounces-227814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6C09156C7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C6D1F24372
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5751A01DA;
	Mon, 24 Jun 2024 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk5NqkLS"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A311A00DE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255364; cv=none; b=qUrFVmhkluvgZMsmWn4S7Xt3UwFcqa88z757u/wHcCu1MXSkmI7BbLBp85L9X7O1B5jxUJUjSoydW0AgzTWOcOegfPQXMCy5jMem6AfO8ALEvTwGt7OqLblzD5NOkuJa2Ml6uWqVGgdqDMjOP+G6ebr8AQd9+9Ve7DM55H2tzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255364; c=relaxed/simple;
	bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=WdRe3CPQ3KrrL+UjDy7USM/hdBATszQ6rxC7+XhQ5TlQM0vbrS+I8X3ZHccJk5B8B9YxQ76nMaoo2EbeGYpYEDh7G3rYH+MJy+saAYCjpjDSt+fP8x5J1MtbZTFdJnWjVD/5sisg0kWZtnPMo4eehyso4KBahqSuRCrgsX851os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk5NqkLS; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f96f8489feso2482420a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719255362; x=1719860162; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
        b=Uk5NqkLSW9D5Z72ew+n3cHmiDjhWfHS+mwbmQ5J7muvtgZxB5Y2sI6fE8VHWM/ZWsR
         SA/v5ScQLJSFGAusYMMEalg8M+6A6SzzvZlhUM7N5wDo2zxdUWiszF0qsEd9mrVhEmhy
         SHpuGSCUAa0R/fHT5MjGPXQf46UBIev983yV8hfEPiHWRQyNM5s5Ii4DrUFwdswpbfCz
         wBPERpM+GIAQSOsEYaFGhe1llYJ5u+G5onUoWRZZVoz0OycOJvxRvrBWqJ+ptFv2mF+D
         7fJtNC1+lWTfpWPi0dPP26HZ+G5eSMs+YW0zMIZBBgzdFVdIalMTkimLUp+h7ZP3yilx
         Qbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719255362; x=1719860162;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
        b=ks/SFb3ZFYL+oOdYlvGVMQ4hSX1MN2IbtY8gDJYzAbYdeXkF+mvoJiEU23RtrL7Ode
         //2iy7u7yLpY2Xki3nSDzEQwgHGYzqoct/Ubv4VsXlzMYIvSRdmPDAAzD1rY9+qf+imd
         d4es2B4qd28VBCW2L5maLEq/5pEgAbD6Er4qhZAU0Vo/IpSwU2dy04q6+5sH1SxTm3Ea
         klfITpR027V27K6YPefS1nQEO+2Ux9RtTcvEm04QFpupJPO7zuD+jQ3w2uaTMfqTD0Pj
         QYQaldrmU31E8wvmC1ph59B8HFeoPoTuGw0KRfPum6HV2l4an9J3Y7PxmlOkOiae7i1H
         +j2Q==
X-Gm-Message-State: AOJu0YwD2HryJoBkCgvKLx7K9Lozv4xThaGAfHZUcCEmUBmb7D7fxorf
	vG/NuYoPjkjS9b5CTWROFDlFNLaVrO/21qsfJWePZDtiJE4smZnbFcSoeA==
X-Google-Smtp-Source: AGHT+IFGetpanxz0CWr7KPfWHq+FBLD7wOmIE+TLccAEYPD+ECngPQ6mBSlKiVXtWIkXo2cDOLIW8g==
X-Received: by 2002:a05:6870:2198:b0:254:a881:cec5 with SMTP id 586e51a60fabf-25d06eb8255mr5763369fac.53.1719255362036;
        Mon, 24 Jun 2024 11:56:02 -0700 (PDT)
Received: from smtpclient.apple ([162.220.44.18])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716ba5b5f58sm5839782a12.73.2024.06.24.11.56.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2024 11:56:01 -0700 (PDT)
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


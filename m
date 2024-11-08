Return-Path: <linux-kernel+bounces-402381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68E99C26E8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2951F22597
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1380D1D63F2;
	Fri,  8 Nov 2024 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="likTvx9b"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4E1233D92
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731100039; cv=none; b=iv4Jj8ro+Oi2OVM25KmE5rAUBZvreCK09IIB1xAuizbeoDf7KAYQpNimY4IlgCUhiKpnuN63mvaKCUkwEfJ7Kl/kMlzq4zd+ceHRmQxf/2kFKWM6IHf4drtgQquclzc+m4XTH/JON/QzhmRxC4Juy/mtBbYB4me9ZCth+noYAzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731100039; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=iYeMRL1d6Ezv+yfHkGwxCZsvinYGnq8WelWtjkiBkEhIcsYo/UP3jXBgJYBK5NrfK1hm3+Kgfb41D/iGgJnoLPRsgozBOA5UdYnztyO7pyyR2riRurTN3WfaE46Ta+Xqhc8NGytqX+7vQq5FDgMKc2qVoBD7l8jazCgIgLZ1Jtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=likTvx9b; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cdbe608b3so28268635ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 13:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731100037; x=1731704837; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=likTvx9b8yXzeWt8r3aS0DZ8VDzwGhkRR3uUP4Pygb69mMnDZbGaB9wpsRlhSfSvHq
         huqfIpQePwhpuzNDHadinWOhczax5rBSTo/NXkO1F14q59Nd4MYppn6+5WFpseX2nxqn
         lfg6TkZ0ETmONmI24KEWLNrnT0CpGODUEnvjnebFX54FbMdSX0Yp55t/Cxit7e7KMqZ2
         p/oJzqhlIb08c1zg/USmdHfmqnrpD4ySZYi2crSb+mRboSO6dzZQrJRFlFHYJOlhHND6
         nUt40LThuWRrZ71BZELK8oMC5xhpHcb8XfIKfELq2J7p+FUntAHhWpDpVxJ5cU7+Blc+
         nB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731100037; x=1731704837;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=hcmVmI1TeBN4IpyGfgegTtHmOeIJH3l2/lL0BQooqzsQUeWtvKproQpyfpAAhuRZSD
         JvAXD/CcR/RYO7ZoeNxQaRYDPRz0o4c6mIZ6O5567q0EByPzssne4tKAcDVSJGMV+djQ
         9N9Q3Qt2bhm7maelL5jn1OKD4dEt3Z/tYHStf1Oq65T20msWvBQYnzJ0kZhYO6RSKAd2
         61dZlzakNauxEGprSEtfoR3cco7F208bt14Bf++u3WZ8T69sJK1kuYGFUwsJ3ZQL5ulC
         UzHhb7f7Sxv2ptHrxB6/DVUGEHAa4MQiTAR0TBwJIxn1UizjWR4Qp1/9QBcD4ujRxhty
         ILoA==
X-Gm-Message-State: AOJu0Yy2qPkdC3/hKC8DFg4gFkkxtfNjw3K1ih3VtsmEQ8fOsgn8lqsZ
	PytLHhdvW5xlmZ8GZIeXshW8VnxYYUTZ96L2UHKbFr5RBsTlz3CVDUqDfQ==
X-Google-Smtp-Source: AGHT+IE+BV4LDtX1qwrQrq90MbLR+m0ULzpA11vE0bpvoEToY1bYfCP5oJVupOGPwPYKrPx+wK5MMw==
X-Received: by 2002:a17:902:ec87:b0:20c:e724:6de7 with SMTP id d9443c01a7336-211835519c1mr55297295ad.17.1731100036780;
        Fri, 08 Nov 2024 13:07:16 -0800 (PST)
Received: from [192.168.1.66] (99-72-227-81.lightspeed.sntcca.sbcglobal.net. [99.72.227.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177ddf19esm35511275ad.92.2024.11.08.13.07.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 13:07:15 -0800 (PST)
Message-ID: <eba0a79d-f1f2-4a85-a3a8-be0fede0ef80@gmail.com>
Date: Fri, 8 Nov 2024 13:07:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
From: Shuxin Yang <shuxinyang.os@gmail.com>
Subject: unsubscribe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




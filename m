Return-Path: <linux-kernel+bounces-526826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB859A403EE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01719173F3C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF202BA53;
	Sat, 22 Feb 2025 00:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OHXfJPE0"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8574C6C
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183186; cv=none; b=oSQpz5bUZ3fnEaLJRS5KZ9YmGIGLxtg5KxSI2s2Opij/RurNLmpvcpzdgaBZ2UIkMoApmrWDuaVJY8UHvpSUYUNjg/KKIeHM8q/XI99DLTHIxK4QNINwQ7e6BAwdqRUmKqR58NwUcvnx5grAc6VKFYwLVBTbGUhzjgLhpj89gF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183186; c=relaxed/simple;
	bh=51yncecrfj0RsMPvBHqMPp58DR3VmCsbq0CeL73I5lE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R5sq3KAapmfVrA5qyphbgikMnqWpFFhXIoaWUtkKmaIMo3MRHSDecm7/3wtmaC7K6GaNdG5D3o7eNXrOK2W4rBai9RqPESlimgwR7jn0vVRSYZgSWiDTp4qgrit/TyQDE56b2Cmc8VmOWbAtfqV7TJIDyJLneyWD527Crw3up+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OHXfJPE0; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d2b6ed8128so11410035ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740183182; x=1740787982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsufKr0NGP3tYvsFVv0EO/2yZiZEnUNT84I1RxYAoyM=;
        b=OHXfJPE0LlToVRPlme+GzfHuTUe8byvdNZxm9x0O7BvfagIwPNGSx/4l1psKSGvoNv
         pXaJyb49NII7hiQxCIKJTx1YvVmrne2KlbQX/RqK5izMbKwrKI2/9GBUQEC+TwyoAmrR
         N2wtrR+m6onpIGxT2QtaEDpukz4cU17UU+U1X9Ivi52JeUtHTZB5Lc4J9X9frdOJMXyX
         SKsMajYx8j9wzplr07W6NmU4sRkPyw6UZEmzIyefPpHRIrZDAuZu1LT+rbn4/6RV+1mP
         ylpXf38934eS1J1RBAz+dQMKMojXl3/ST1wkHwcczOgTLHx5ISJdAIdEmNjRSTYEfTED
         U9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740183182; x=1740787982;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsufKr0NGP3tYvsFVv0EO/2yZiZEnUNT84I1RxYAoyM=;
        b=cwKXT1W4lVJhZTfekE0Wju7KB1p+A2OzxVk4OiKrgTEK6WY0h1WSmS2mZ8hA7/g9bm
         Wb85MhX/gE/P+DhwHNdEznUgqkD61Mh48ZCnp11nck6N3Sxn8qyPa7sLrkBXU5XfyVfz
         ybVQixHPcU7gLCIbvXE0UFWF/Qp/QkiC2GUjvpUuOJR24xgx0fhcUr96scqziIig96/n
         sCSXhWzM9+ak2UM4m6Koe+c9cvOS9lG5M4J6kOfdbURKyC5vuzjRDOAGl8LahfbQuWH4
         93LDOQM/BXIMhkxhgdYnVSJwVRR+pADfWH+9qHibRZ78b55HuR2uuuPn/zEtVXJwD0OV
         X7fw==
X-Forwarded-Encrypted: i=1; AJvYcCXncvinrYnG65QvBXh0UtFADWT8Y8ZY5/olOJ59BxXS/zme1iIDOvPm+e3QKSPc3quY31KrLgCgHBrjCG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYwC8u6ej9uK7GTiZTflSGqGPxy5LZnOGH7DNR00IIgsPVRAeV
	M2TMf/zS3Tfg2rl6UWDmFAM3lCbViI8etwf3njtZPdQ1F+M27Votr2ebwcrMR0c=
X-Gm-Gg: ASbGncvGo02bzU5c8e1k1xk1k+p6Z4J0UtfpF8ycrLedkG2q5/WYIkXod2qY2scTyE7
	SeBLWEGOgrEqAIpz+WNVtA9BMGqp1v7W8ebTPXalKxx+0kwtwbczy3mJSO46Anpjtpacip1uSgA
	g2vyZoefb0FqKTYGGP23ZKKNuqEX/MODU+exsIaPMD9ZlwjKBlOwWr6VOtZlz0lusLzREvOiKte
	61weEkpJJKuqTDcNFVS8jbOQsCGjCFmrKFb9XB7GYBhhVLS+Co01jHnJ8f/JzDGnCBSCRe5/gVK
	88hzZ9YYpLbOAO8NmQ==
X-Google-Smtp-Source: AGHT+IEUUpAfwedrwX8Z7yqaUa0AGKI0ihxBNgw80Nems7KCQtXMFtFcx2HmpwlG19S5/FlE2ikssQ==
X-Received: by 2002:a05:6e02:3dc4:b0:3cf:b2ca:39b7 with SMTP id e9e14a558f8ab-3d2cacb0022mr52274585ab.3.1740183182418;
        Fri, 21 Feb 2025 16:13:02 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d2bc19dbe3sm13388665ab.9.2025.02.21.16.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 16:13:01 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250219205328.28462-2-thorsten.blum@linux.dev>
References: <20250219205328.28462-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] block: Remove commented out code
Message-Id: <174018318140.1822587.9741571517838734087.b4-ty@kernel.dk>
Date: Fri, 21 Feb 2025 17:13:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Wed, 19 Feb 2025 21:53:25 +0100, Thorsten Blum wrote:
> Remove commented out code.
> 
> 

Applied, thanks!

[1/1] block: Remove commented out code
      commit: 8985c4298733a56d38c11948dc3b1dd24f4fcd6b

Best regards,
-- 
Jens Axboe





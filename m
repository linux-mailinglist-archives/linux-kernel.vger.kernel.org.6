Return-Path: <linux-kernel+bounces-332454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F4097B9FA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25E41B2908B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB72176FA0;
	Wed, 18 Sep 2024 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbibdkHC"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F851139D09
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726650323; cv=none; b=R8AlvhTwHaEz7r1naK2QoAlqRr+q2zDYy57h1+/Z5p5eg+/Zcs3zeosqfcrkVBbvy4F/tpIWTDIPDdDAbiYubROU1gRMA99XTPCSlclth7FNKMhMoUASprADpYx5I+AHlGLchblfEBZmVnclcVZee5Cm/uwHux3J9fG8DO1lxs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726650323; c=relaxed/simple;
	bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HvZYQR6EmjpcOjESyHR2mZq2dht0m1QKmtF1tjFwzsnZ3OhiEjVyfldleqVfrKXsTAZDd5d01rjwP1Ep80VQTWRj6dwCx7QkU4BJ157gXR7T8MpCzsGmRtO0owiCAd8D4I3zmnKE+qvSqtF6GYvgBQCJeXtyHPfFdsmDMKp6lDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbibdkHC; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-717934728adso4982285b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 02:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726650321; x=1727255121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
        b=TbibdkHC4fWhIV4NBU45TlMX8mOuubknDKPPj3arhwQSv/7/+LuTkPUNV3GObEgjqV
         G7QDrYImOKNcyp+UQpFw4vntDzFmPWev8d4lVYIywItDxQM/EezCRUULC/820+f5/AZk
         BibVO2eAl9oUg1h0Psf059ajeyjuimodFr7fao/dQ+61THd+Pyt/eK9wnXMpZRln6eWQ
         8XO1l93FXHxjaSre9bzfXdqqDnTHlxU0wRSWuJwoKsQdlb1RYOeYllG4e7ns5DikM/0A
         zgXTbTm7nBXCPgPp0fj3n2S1ZHgEk8AdxpKIeccu8uffER9NUDVusOIGrjp/srQgu8fP
         oWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726650321; x=1727255121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
        b=mYWR7fsTwK3ENRkrTUvPBrGxzRvZmAL3hcwJmXalfJP174pYV+mrq+0YGZHqSZ9lyV
         BGHbHni7rRaqRUqG97vNJHYj3RyJbtxWNA2TcLNbghJGa4NTDngRnfURQWYO9TfrpQUP
         QZ2955R4G3vgaz0IfhnEpPgZfZ1MF2VIWdZSlMHoN3kMbOjU1B4LH2fdRkH8JHPY3E5x
         CvQJxG2VpxQBVxyeItNSDGtMuIpWV8ym9v+BlknxhZb5Box5CdOK3+5WtZxq8AIbU3d8
         wK3zxHFAketEScvyJHMRPZV7l5xa6klth4iksvDN7kIiKe9xirlso+AcTAnKzx2NivXf
         Tydg==
X-Forwarded-Encrypted: i=1; AJvYcCVgV94A1BlazAzZ25AbSzQfPAER6Y2LkMv8bDiLLxjPOc0vgFpLOx6AE7m+ntX2VBl0se1wlqh4ibWJYeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdsMxwfaDoT+8HdPs3i9LBShH2G0QOdTtsVEHmS35gkhUgiGbM
	vQ9vRISODhIg7ppshg9I9rnPZXHBO21gduTq9dYoAY8SBlKsMpmD
X-Google-Smtp-Source: AGHT+IFJy54powQlrfshsQ5xCW79pM2+RP00gVXqOeqEiS584otwA8vWLYrbyi+HnBJp+3U9JvC5KQ==
X-Received: by 2002:a05:6a00:1953:b0:70d:1b17:3c5e with SMTP id d2e1a72fcca58-71926067e78mr31677438b3a.6.1726650321113;
        Wed, 18 Sep 2024 02:05:21 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b97608sm6326005b3a.153.2024.09.18.02.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 02:05:20 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [net?] [s390?] general protection fault in smc_diag_dump_proto
Date: Wed, 18 Sep 2024 18:05:15 +0900
Message-Id: <20240918090515.212605-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000fabef5061f429db7@google.com>
References: <000000000000fabef5061f429db7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


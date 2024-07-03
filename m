Return-Path: <linux-kernel+bounces-239378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6BD925E0E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2DC1C238BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3686173323;
	Wed,  3 Jul 2024 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs/PWpUn"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550C1DFC7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005967; cv=none; b=Kiqs0/6uvRZK6ajb6l2J0cgsyLbCCvTlplPqwkq/eUwkCp58p5sbNpXFwA/qK3OcWitoUSDymdwxPoIMILCraIchOMCN4DmvMIoM52OXmy+h7hNjqlnOJDi60KZOGhk59LV3osU6C8bRBjMS1FYM+X5W6w92LHOxK14p7peIuPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005967; c=relaxed/simple;
	bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tCePeefuQz8Ym+CdL1YhLi9DssDEZu/Ji0ixr2WEHTzoBX3q+OJIQYMj0OhkmgKMhTvDIfvPYlorUTqh/JnZvQStM5b4+szm/o2Wm0+0A/GKAnGr8nqitwPfpElu3YA4vtwb2/ZZgtrLXk8O03NS0UN9/Mo4P9HUxBMgIy9E9GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs/PWpUn; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d846f43632so1118610b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 04:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720005965; x=1720610765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
        b=Xs/PWpUnO8eabG88le2ru+a6lEE87PznR4NtcU7jNoeRYJMwRSFe1du+FbN8IvUjQt
         vmGpjZVNPqx3pU4HfwYnTNVqJwECBKU2jLErcIcpID4cCKHQy14LKWGn6U6TN9iKPmtU
         kIw2LSUx0g9bhTFUsjL6TCyTE+9P3501N0LEQAQjd2Bb1Q/Aciom6jWrzRbFlGVKwfD2
         11qwxFbmt0QDRehz2JCSZR6rN3j/Zp4JJKwLIgtVxYdfVwhgcusrYjCLLWa4ROZCDqev
         zxYyDsMDXOP7tmI/uxTjQoOHgtQuwMGSpOgwCb6uE1HL6qwjjvxps9k3Gk6YlVaow8/+
         hdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720005965; x=1720610765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
        b=YFkAeJiaxVmLzJsThl2ZqCFjR32wviYovaOd9nOBAv/msv05//7kzOce/lyiltTALW
         pIKfbADnBCu0CzBjPktDilHL/yzR8h03j/Mveh9loBv4XvOmltYHsTXQdJbufwBDAW6m
         ylYPWskbmruYFsT+iu78RATAnMG5JXQipzA+0G/g+rJyRmEMxRxJHeizA/0lOoyzzLVM
         q4cTckO2+MjH4f0X6pDzzIZ/mjnfy6cVegNEkc293r2VHbfCg8gf/TQi5KL9sszCvAzS
         v2ms2H7x7hI5hPs29BLlxyEmIAN2s9UIEGaGHGH5FlzfcYBSdP+v0DrckyvAbHKpKGRs
         Oebw==
X-Gm-Message-State: AOJu0YxL/AnEMSY+iOKzZqOGYdKjp2MdE7mx8LVEcLP9z1X+kgfDCkmA
	AhoZ51ybXKy7rdXpV140/nvUKvUNXlQ6FsaFgtzWUwTR6+3fDxXk
X-Google-Smtp-Source: AGHT+IHacDzbtTbr32QLqx8IHI1vNzkn4uDv5STPcl0/7fwJz9xPvDR1+JO4LCwb9jKDwTHI2UGFjQ==
X-Received: by 2002:a05:6808:16a8:b0:3d8:4603:e7c0 with SMTP id 5614622812f47-3d84603ea8cmr6940672b6e.21.1720005964732;
        Wed, 03 Jul 2024 04:26:04 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080256afaasm10194544b3a.81.2024.07.03.04.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 04:26:04 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in team_del_slave (3)
Date: Wed,  3 Jul 2024 20:25:59 +0900
Message-Id: <20240703112559.65375-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000ffc5d80616fea23d@google.com>
References: <000000000000ffc5d80616fea23d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


Return-Path: <linux-kernel+bounces-242088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEDE92835E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8673282274
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E579F13C67C;
	Fri,  5 Jul 2024 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awfF8pV4"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D17F481AB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166563; cv=none; b=PjTtG3p6zhOgIOzbwHfGmaD3RQ4sZAFynf4ZhWNWlIa7FiNOAJ1ErEbnb4UIYhJGJbLbVLnl3voZS59LLSxcV+0loVCW6GMC0gKTvIb2em9RG3pS0/a5M+j2OcAVd58CH+kKhRVMPSyzw+meimR5/MKaVMP0pzGpupey4UeJzQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166563; c=relaxed/simple;
	bh=TTzbil5e0R4ONX/+5v1kD5Lg+fR28Zs13KsyNPGQteM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F3LgPReILtJjILCuGq6ARZL2B/vnGo2Z6CD7WsmJ5MS7AmqatZfMQZ8AIjs864jlBJzzBiDGUBYxRPv9C6QeKPrOchYhwI9dbsWi3KTRWMi/yJ6iB4+UXyMhiDxyoHErZbxcUiG6Ys3eQ8dLULs7JW2LVba8u35da8dl6hDWANM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=awfF8pV4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-36796d2e5a9so918933f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 01:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720166560; x=1720771360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7919uSEaf25z1O+cnc0ksbGuMmxP3m8/7mlELasCsa0=;
        b=awfF8pV4HVI14zNIXOt3aR7jUiEs+yJyR86od33cdvGaWhogrAa2g0+4IOj4RHB1bl
         r1ErNpi84Wo0VKbsBFtSuJ2IzrXlVku31KpOwatcEIxwcCntDDQOe1SGPL9hcSbdhMcD
         K7UU4uZpXAbaTYZ+N8qrNtQEDMRRUPcmuWg+E65BOLuYUaufHA9age5CC4Pz9iMUyLw0
         mP9SsYT5oRRuUCJGjgX3r5Wn+RNsP2skBFA+KQ4ngVJILZ80A3EUyAzxH89rFf8DyMFn
         7YLLXtWaMKGdkjq5u1AyfpBDJP3Ui1N42zuEOLqohcLgGRE7Ggavt2k6+KkViq0hVYB+
         PP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720166560; x=1720771360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7919uSEaf25z1O+cnc0ksbGuMmxP3m8/7mlELasCsa0=;
        b=hVRXJoEVbjnxHroJNOqvyApVnRKSMZBW9dlJZXEKipNWD6R6mpR/aKuHtPY8ggMxcF
         vdji9MOEnDivju/OT3dOecbtBUn6LwQsXZ+tc1njLmSxNQCOBp5crQnj1jJ5SrIOYH3K
         8sWQHM14rfiE5vFiX7zbFTnutcxuAkv3LvmhKNIZOY6IOt2EXImSYyZ5/yKBgdnNfWPG
         gjl7vynAW98CY9R8xsdRt8rdKCtCf8XzPN0o+hAAfT36KTbsj0m1LA10RoPAE9t2rzam
         7S9IzUmAFALCiWPQNAGZu9A89d08HDcN1LvxPF01/i059EAo586/TA6DvycpwAbRrVzI
         6GcQ==
X-Gm-Message-State: AOJu0YyNStHdKWlsX0XUZsSdFaNtWyiYHNOjybThDGW4+usqrlQ52Wvp
	1zeWDxjezSnQcNbqkmBCT4WLNyfua5TVX/qu92UZiBM0ppm9O2lU049qDKfHzsw=
X-Google-Smtp-Source: AGHT+IEuWgMo68kSfukSJWs5nr44esLjVIhbZVQ/oJI9+WlLjKyJTk+kdHuIh7phkrwj2QlzLKwITQ==
X-Received: by 2002:a05:6000:b81:b0:367:958e:9832 with SMTP id ffacd0b85a97d-3679dd17ecemr3359518f8f.14.1720166560025;
        Fri, 05 Jul 2024 01:02:40 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a103d00sm20263703f8f.99.2024.07.05.01.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 01:02:39 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/1] slimbus: patches for 6.11
Date: Fri,  5 Jul 2024 09:02:33 +0100
Message-Id: <20240705080234.424587-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=310; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=fpTkbQ+PcoQTv8EXAGm4YhI/HQ+xt48gNNud+gggbRw=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmh6iaEH7vEq5PQNXUaAxjxXOc4b52dJR+VLeKh G5VXg1fECmJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoeomgAKCRB6of1ZxzRV NxRIB/9NGAJ89Ex3x2s0IPvzvsDlpTgiWbGFd1Rso5pa5+EJnTwdJvucQYU5/gztaiANF5MVsWk dr+jGwKqSOGTnwvFBKLTq9WGbmKS3Z+8r45F2GEdmwNAwOSzf4EK9OfH/2N3VD0/AkOZqbGKQsU 2J8uK0SqdTEZpHUM3bjv5BTUbIXgiFhAX2AclvYFE5HmxqaGh6V3ony37PNFC6xjdLhJ0lJUmA1 ozErIHB8nzfkHSziku403bK8a2xmjQzaTp+IbV/QRyeUl82cZTRaKCwdUKlGxA5GEfZWigjaKMh 27W5UzOML3H0Z9gD2UKrosBIMCGKA5tzjb81tS+tqDHP0vqL
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here is a single patch in slimbus for 6.11.

Can you please queue them up for 6.11.

Thanks,
Srini

Amit Vadhavana (1):
  slimbus: Fix struct and documentation alignment in stream.c

 drivers/slimbus/stream.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.25.1



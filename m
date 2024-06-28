Return-Path: <linux-kernel+bounces-233809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6019A91BDB3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A131C22D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D62157486;
	Fri, 28 Jun 2024 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ze8449Fi"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777006F307
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575179; cv=none; b=AfoZkFPA+6AhCkvzUW35aKXsVRgk2sNVBnKfc9V6hnFKhusBReeQ/fDeMW/8o/7JPxBOtnzuc/i5G235MOLzunEIWnyygLvXfd86zgmSWw/e03R/uMkYSJCUZjgTiSDKkSd6mc0RDMH3ImOvW0UC5av9zSViRYqdCb1crGmDxa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575179; c=relaxed/simple;
	bh=FmCh3vhDcminOJ5oxbQe8nKBn2kggDf6LKWUk8S2DjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N91KoDM6/B0bZebrlUr5WsWIfTTQTcMTArNhuL1850QE54JOhDwF9Lcx4R50CTrNg2kPykDeMJwgLd0bpfAVZIj4HITHw9GRvvV2JAXgxfbPYx3/T73EnFgBY8mXOX2ibvspbfFaCZ46FBnBd+v61jTgYmPNl2i58av1IEzdJTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ze8449Fi; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec002caeb3so5730471fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719575176; x=1720179976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2I7LgHduyeRKlSyWEU+zIh3JbUaABXvrylNub/6ERM4=;
        b=ze8449FiS9kcG1fcHFCL1PONcsGTidu2qBIv9Oy2vmQHxuqR92qBooAfYA6wA71/6t
         x+ZSNHIOJv+5bTrYTzTDz79LZutggn2UKoqfEG62sIQbWy8WrMTO9SKlEfinvaiCYXxO
         hxvnOF+Mit5uCZdoHmeiQLYtf9tmKW39KNYZYIHVjPIyWshQ5dLJQMwtbNH9WU8kyG/d
         lQb+Fp2yOOMCGnOIT9PwSTq2KP48bqASjn+DKP72jPAxomINARvPD+AGzMKXJxd1S/Hm
         hT1TPK4AGZzLCwMoZq5eruMVrWSnnNFNhLMKWhRyNU5rGLW+mR8h+qGQXaEUJpeN5b3C
         pKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575176; x=1720179976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2I7LgHduyeRKlSyWEU+zIh3JbUaABXvrylNub/6ERM4=;
        b=H1RXoNCcwkBsu0XkhbmXfhdSlkk9Jl5JO486CLD35KnIxPIiwmmdW4PF/6aeZASAgx
         QgDo3xYArBVMA7QzP2vxqWqWZvssV7FBZeMtOEndaiOTJWp3z8IUYU/UB3ut68/TPy0j
         oNeP6w0PhG5PVmeq5PBSEAbpfc0G/7S/EiLSjx4Khgwr9cWqSNTtnbvN6pSFtlFVAPK2
         TrnX77/kTrU26nSwu1vk+mq6sb+DnrE8imIl/5C5j0Vc13yu9ECnjq9/B8LiYjyTZ85H
         BAOcmNaUZYfzGzkoSyrpn1agSwxkJq4rI8vsgKBXxSZI7Q7kuzqwnVIcrzyGYu3VvJKL
         g1lA==
X-Gm-Message-State: AOJu0Yx8Si4rYWKXyvMdkeehttm4yPFYzLG4glxALlGClxHcVSspIUBX
	pNC7Qdn/trYf2eayWRh3nZ475HXDhJvL6/So6HrnfKd6ldihopkpDfWgssW9kLw=
X-Google-Smtp-Source: AGHT+IGeE1DeLR3VhA4o3T8/TJWZX5Cj/04qVd+D0v3p5/Ea9SgoWz/MUdRDqRtoFVldupTRc5e0cw==
X-Received: by 2002:a2e:9d8d:0:b0:2ed:2765:2491 with SMTP id 38308e7fff4ca-2ed2765258cmr52354581fa.28.1719575175663;
        Fri, 28 Jun 2024 04:46:15 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af389b3sm32721345e9.1.2024.06.28.04.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:46:15 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/6] misc: fastrpc: fixes for 6.10
Date: Fri, 28 Jun 2024 12:44:55 +0100
Message-Id: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=771; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=M+lIo80cvpcH/NQXM7OsApzYtca+gVNwBOzDF2lY040=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmfqI9JXibIxjExHG7Z9fKugA/F17M1hnm3ctwr pVg23ikOruJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZn6iPQAKCRB6of1ZxzRV NzH0B/42Tz3HY4Py4X+jFStMZumhdnzYa12NAoqUCPK1Av0o3oHln/92tyQI7ruBQ3r9IYp33Vy sdVvrNHvEuf9PSgh+Mg6HyOFRRDJvyJSwlJ91hH2SpQFRB7cs4UflASvNV6QustQ96sEvJm1fn/ 4WmnlUghKnIbZ+p658y2uYeG3gi4XH1/prXBD+xfNoCgbauWHd/t4Ei7Tb/teWe4wlYUtyUAEqh NXKNDZX3qMaMnYb3fLQDH+kIJfyst0ODy6SsjOafjyQ7y7UjUoSSQm01WxdaGjGgjdsU4P7Kcww nYY5aXSsXnhlxKVMXSz9/vOu1oXll6C5P3iREIRdd9ztZsTt
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are few fixes in nvmem for 6.10, Could you queue
these for next possible rc.

fixes include
- Fixing incorrect handing audio protection domain
- fix capablity query requests.

Ekansh Gupta (6):
  misc: fastrpc: Fix DSP capabilities request
  misc: fastrpc: Copy the complete capability structure to user
  misc: fastrpc: Avoid updating PD type for capability request
  misc: fastrpc: Fix memory leak in audio daemon attach operation
  misc: fastrpc: Fix ownership reassignment of remote heap
  misc: fastrpc: Restrict untrusted app to attach to privileged PD

 drivers/misc/fastrpc.c      | 41 +++++++++++++++++++++++++++++--------
 include/uapi/misc/fastrpc.h |  3 +++
 2 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.25.1



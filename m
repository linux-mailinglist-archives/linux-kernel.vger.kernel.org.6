Return-Path: <linux-kernel+bounces-423414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8899DA71C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21954B24180
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397DD1F9AAE;
	Wed, 27 Nov 2024 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwnwDJGW"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3420A1F943B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708030; cv=none; b=f3TKSXAcBQW8aI8VMqF+ODfsZudhUU1rCBvauJPEiJhztsJBdLyppcbuSZrl3ju+LCzr3IQ336bJVntbDT/f87XbPLjzAfPwL5mq9oUaXiU4gyB8v64xRXY7fIrNPwb9Pys1dHJrrACDRkRhfpMhj0ROvpgCJpB54N/mIVIi1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708030; c=relaxed/simple;
	bh=J5/fhoH6i58GXj3baYtGSEX7+5F+qawvOm8iLG99tdo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LUU9TJ3pf0AfnweOUnhV5mutAK4LuaT+LF68gLFjONF/k+P4z97K9WceGgHy4ogFtuNoBQByQaeNxco+gNuRU4UIZ27mOD1QmKyZp99J94KoxP5p5evUjCQuHheLR/MelDg0e0bolBacTeCawLbrbLXlkHBQPqK5bxEmsaTvKHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwnwDJGW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-211fd6a0a9cso48709925ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732708028; x=1733312828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kh6bddqnZi0Jk8P/+StFE9apNLAJyAYwCrJWGP3mQEw=;
        b=lwnwDJGWGCcah6sVj7Wma4qVZfamVslJoU9yWZxe0e4/VAgPGKD8W6F5ypnIrU+xZB
         Z3ctyFmiO5cPwGteo5xIR+mlDV74NdVkHWYpsp7mqgMAQI9iIivgzOcjshXs8Dixbi0E
         AWYwnHfGk6bY0xCBJ4UXgd/cmuxv+Qm3FMLj8tyanj7uEn2FuamMNUdPGXo6+glqZPLQ
         CevAhK5tqo6crgUyacuIST99WbkHdzL8gUv/ju//ML/7hRoo0GMLZB/nJmbZsSTK8G5Q
         cWA3S1wNiUxIy0tzmGugrRXcEcjt5UpI/FqzRlu5Mq4j+TKUEjKisi7LnaijblN3qH5L
         GbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732708028; x=1733312828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kh6bddqnZi0Jk8P/+StFE9apNLAJyAYwCrJWGP3mQEw=;
        b=nxes0Tmf1749nBXlz1vPZKhD7j56eRHhwvKCG+IqP8XcPy+n0gZiSkiCfUVHEAIod2
         q+feh826EW8CNyz+5pEGpI/fA7i8OL7RSWbz2hf4dULX97prI3BdQPUhVhAP6gpjY3OU
         va8JcTGfkOq3sba5FF2LEJkatNH6uOuluxVwAw2lzUFWRqOGik7w/t0a+isgOLl5W+Bp
         uIqwEhLsUZMdUGDq8cIMA/xnDtQCogIMgDPGYSy3tM/RW8eyrMWCHgqaU4KnHlyZ/IFX
         b76mzlslhK731GnXB05YPOtnVnBv0lk5doK+CcvZGIGRhyh+r5XhRtRTQQ49OCDm7f6Z
         VQ9w==
X-Forwarded-Encrypted: i=1; AJvYcCULotkCU7Y9phpehHh0z/hjK7uMV4aCeeqgulDohbv2Jd8ycDTh/6KyvuNbxoO86KNulMMq6A9DzuaBl/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlY2Am2iBETxwEP8GF8gK/scT/AvuRlJM225EjtnhhtPCOkoTS
	W/iVPRYV8veWIIO7SBgQ3RBGvVXPktDcrDtCC/eI3aFOAR4adQkB
X-Gm-Gg: ASbGncsPj0J1LHDqpR/9e/Az0fb+Y6EUOXZLYV7CUvWOupqLH2oAlb5p2UnpfA1UEFx
	q+XSny4MYWAfCPfNIoSrnaDx8GifDzOLVGmV9l1DMg4hTqU8PAzYtmNrYuUCfYnfgDVAvRMmDsy
	clwJ0yJ8bwJIE+q3IAmS4YCX5qYaMNw6Qqf/XkUzaw1U0MJ7zCGW51xTYwXPvbpufydt8gmeHO/
	yCAbAhW3pVrPwJdXjDiJntIMmhQknPgGjka5Fab3e0o6YeCArVNAenOPCtqSR9ybbqYpKWKeqYZ
	3w==
X-Google-Smtp-Source: AGHT+IHihpjvcI1BlDLzyC9VZbD85R46tQlCudAYuP0VXXMA7mlJGUngy95fEvQGSagVPN/Fafe39Q==
X-Received: by 2002:a17:902:e88b:b0:212:55cc:6ba7 with SMTP id d9443c01a7336-21501095f82mr27411875ad.4.1732708028190;
        Wed, 27 Nov 2024 03:47:08 -0800 (PST)
Received: from miley.lan (c-73-162-202-2.hsd1.ca.comcast.net. [73.162.202.2])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2129dbfa834sm100805645ad.117.2024.11.27.03.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 03:47:07 -0800 (PST)
From: Mika Laitio <lamikr@gmail.com>
To: christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Hawking.Zhang@amd.com,
	sunil.khatri@amd.com,
	lijo.lazar@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lamikr@gmail.com
Subject: [PATCH 0/1] amdgpu fix for gfx1103 queue evict/restore crash v2
Date: Wed, 27 Nov 2024 03:46:37 -0800
Message-ID: <20241127114638.11216-1-lamikr@gmail.com>
X-Mailer: git-send-email 2.41.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the corrected v2 version from the patch that was send earlier.
Fixes:
- add cover letter
- use "goto out_unlock" instead of "goto out" in restore_process_queues_cpsch 
method after the mutex has been acquired in the code.
- fixed typo on patch subject line and improved patch description

Patch will fix the evict/restore queue problem on AMD 
gfx1103 iGPU. Problem has not been seen on following other AMD GPUs tested:
- gfx1010 (RX 5700)
- gfx1030 (RZ 6800)
- gfx1035 (M680 iGPU) 
- gfx1102 (RX 7700S)

From these devices the gfx1102 uses same codepath 
than gfx1102 and calls evict and restore queue methods which will
then call the MES firmware.

Fix will remove the evict/restore calls to MES in case the device is iGPU.
Added queues will still be removed normally when the program closes.

Easy way to trigger the problem is to build the the
ML/AI support for gfx1103 M780 iGPU with the
rocm sdk builder and then running the test application in loop.

Most of the testing has been done on 6.13 devel and 6.12 final kernels
but the same problem can also be triggered at least with the 6.8
and 6.11 kernels.

Adding delays to either to test application between calls \
(tested with 1 second) or to loop inside kernel which removes the
queues (tested with mdelay(10)) did not help to avoid the crash.

After applying the kernel fix, I and others have executed 
the test loop thousands of times without seeing the error to happen again.

On multi-gpu devices, correct gfx1103 needs to be forced in use by exporting
environment variable HIP_VISIBLE_DEVICES=<gpu-index>

Original bug and test case was made by jrl290 on rocm sdk builder bug issue 141.
Test app below to trigger the problem.

import torch
import numpy as np
from onnx import load
from onnx2pytorch import ConvertModel
import time

if __name__ == "__main__":
    ii = 0
    while True:
        ii = ii + 1
        print("Loop Start")
        model_path = "model.onnx"
        device = 'cuda'
        model_run = ConvertModel(load(model_path))
        model_run.to(device).eval()

        #This code causes the crash. Comment out to remove the crash
        random = np.random.rand(1, 4, 3072, 256)
        tensor = torch.tensor(random, dtype=torch.float32, device=device)

        #This code doesn't cause a crash
        tensor = torch.randn(1, 4, 3072, 256, dtype=torch.float32, device=device)

        print("[" + str(ii) + "], the crash happens here:")
        time.sleep(0.5)
        result = model_run(tensor).numpy(force=True)
        print(result.shape)
Mika Laitio (1):
  amdgpu fix for gfx1103 queue evict/restore crash

 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

-- 
2.43.0



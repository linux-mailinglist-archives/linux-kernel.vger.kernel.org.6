Return-Path: <linux-kernel+bounces-210911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0EB904A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341AD2818B7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 04:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623042576F;
	Wed, 12 Jun 2024 04:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4wSSCCu"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ECE3209;
	Wed, 12 Jun 2024 04:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718166909; cv=none; b=NRPqBInKzj6JlhYot8PslEP9ohHAzbq4PCYAVne50oRmL3b9gujYmzxxbOQpVDCRfcwe8z/UF4V0bZD7VRBlkBGWCvVsAc3EuLySKOtiwk9LYsxyaxdBUmE3pZwRrQS9hI7QRV2m3lwSsPleb40p66YKB4f2h5gv15NWpJbozSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718166909; c=relaxed/simple;
	bh=U4LY/dmzfg+kHzvbhMb1NS3BJ9kksTomksJ3XlEHAjE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WVUWWD9Hn+95FsomelTyp9a9V81MKesqaQhuBccB9aJxSfBHiuygniOwK7GUYSJanzjZMGnWAruVQsFnUBIc4mrP6gc1ZHbfVywM3oSN6yR8hxJELX/RbIquCYmxNIwFzt0XpvRkrk8oRhDPFwfJ6+Z2DtjWlcvyLxXfZgRbZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4wSSCCu; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c9c36db8eeso928418b6e.0;
        Tue, 11 Jun 2024 21:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718166907; x=1718771707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FcgKiRFptA5wGMWvTtSCxIu+CVZgMKx0LwpVaGdU3m0=;
        b=Y4wSSCCuVYi0CGbhDv0oom4R5cWutryNnNHfdGI4ch9zNMCOlCjEO+xmFd38/CfJEo
         BiJF8rcSm1Y721FizGS3oVQNJIBBM/BEmTGo2peFOhkUCIpaDtZWFy4Nio8kxIal3AiZ
         j2kR/BWcYVs5yk9E2RKvD8nab0EThyWyakhviFBnrheMK9LqmStJg7likgh5Rv2qvGmY
         7p4uxxH5qEy54MiMMwq1jF+bodQNjpdIAsfsudFISJZDoLOAt3cq6QfGJtKHJQ+W29Py
         lMyNpGUVJcyEpgGh1T8HFNJC0l2DH51bNXFrCg57StIVH8etDFG8VBRJ8wFwkdGzIUSz
         yNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718166907; x=1718771707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FcgKiRFptA5wGMWvTtSCxIu+CVZgMKx0LwpVaGdU3m0=;
        b=KNf9qBezdxDHC46g+QkXWnhDciyiGdx/dx6ffcnJ/XyQaC1d3YodsVHAElNq514sen
         jaz2Bb/Au2sTr9VKTLtUultaKigV5hUubFw5yIScAS9bu4PGiLFj82Rbi28rkYC7wFoa
         k/+9Cv5STqLCZIoKrP90jXLZ9M1ZPPikOO3zBonW+tMgdQ7jlVsnhYSgwIb7uzSU0hO+
         LXSYMZS/M7XnhzaGKrKqBnRBLSJg2oFJhbcQIyUAyasjK395JYCA4OJINa9URlDcp5r3
         yW2nCQXkQ68MPUs62H9bgadGM3IZahozsfoHm6x76lGyhpNRNo/a3OChOiJKu5MHyHcd
         JLNw==
X-Forwarded-Encrypted: i=1; AJvYcCU1mKUDi0Mb52NT3MGy111QUcJQa0WwMkiidwYu1ye03eJGdj3uMkdJNTFOvqKc44vbOH9S8C98xu6Y/5pC+o+6901ZiMTZcQi+jJkjuBdQ3+/m0TfMpgzo1Wf01xOLYS1pfNkdopF9IA==
X-Gm-Message-State: AOJu0YwRsvcmjNfy3Z/WQeIyncBAFnsTqV1YS9XltDKQxrKCA2ntS6H6
	8EDjg7L9j2s809M4akGvQ6RCsaQEFmEkx8RX/g2NkZZpc3or5OxH
X-Google-Smtp-Source: AGHT+IEJDGJTwJnI3MRL/73vf8uDAdbsr6Xop1CeeCIYUnDnzlja3WAixsMCdC76m2jl4wXONrXsWA==
X-Received: by 2002:a05:6808:10d6:b0:3d2:3dba:f5a8 with SMTP id 5614622812f47-3d23e01b462mr1084539b6e.9.1718166905613;
        Tue, 11 Jun 2024 21:35:05 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de276061e3sm9021275a12.80.2024.06.11.21.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 21:35:05 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
To: Corey Minyard <minyard@acm.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Quan Nguyen <quan@os.amperecomputing.com>
Cc: openipmi-developer@lists.sourceforge.net,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Patrick Williams <patrick@stwcx.xyz>,
	Cosmo Chou <cosmo.chou@quantatw.com>,
	Potin Lai <potin.lai@quantatw.com>,
	Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 0/2] ipmi: ssif_bmc: add support of skipping ARM SBMR boot progress response
Date: Wed, 12 Jun 2024 12:32:53 +0800
Message-Id: <20240612043255.1849007-1-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adding support of skipping ARM SBMR boot progress response, to avoid
SSIF state machine problem if host chosse not read back the response.

Potin Lai (2):
  bindings: ipmi: Add property for skipping SBMR boot progress response
  ipmi: ssif_bmc: support skipping ARM SBMR bootprogress response

 .../devicetree/bindings/ipmi/ssif-bmc.yaml    |  5 ++++
 drivers/char/ipmi/ssif_bmc.c                  | 25 +++++++++++++++++++
 2 files changed, 30 insertions(+)

-- 
2.31.1



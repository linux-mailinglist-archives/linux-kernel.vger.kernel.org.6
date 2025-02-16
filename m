Return-Path: <linux-kernel+bounces-516437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AA9A37170
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 01:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F160E3B033E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 00:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD83A2D;
	Sun, 16 Feb 2025 00:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shxH02hs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED36184;
	Sun, 16 Feb 2025 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739664207; cv=none; b=NjnsTnQkGYJ2I+SSJ7YOh4b/Ofn8Y+QpbVz/BPmUB5+MT+suO/g/w92WDpZ8auyqmmLjK5Y73K4HW5ukG9iorIh934/qi5UrrB5IikX05GkiBsEex1tXxyi8roCJQEzUVfZJJ3Ll0deppsPrU6z9BAA1sVBZx3w2FRkGBZaLCUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739664207; c=relaxed/simple;
	bh=xGt/JVQlQOuGg/pZcw+eNAm3ifsdJu12WLi5c+cM2LU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RKaiRS1T3NRzlwny4ye0tw2GziRe2SmECWERRF3AHVkV8L+JDuddIvwc4HZlYcVVuXzpPi4F/iKe9sYDQEwRO6hwwe8DJbdH3eZFMhWVrbPIvGvNQHbM8XPwi/Nx8oU2EDG6fbx47ErRbIirhkzm6Tmmxo6rC1MMIHxwgAZoadQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shxH02hs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF55C4CEDF;
	Sun, 16 Feb 2025 00:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739664207;
	bh=xGt/JVQlQOuGg/pZcw+eNAm3ifsdJu12WLi5c+cM2LU=;
	h=Date:From:To:Cc:Subject:From;
	b=shxH02hs+SiRlUHQ+EfiVNIKfyf316DEDuH1Lw2aSjc5YQzqRzE0BWCiudJjA0c5L
	 XYB6vFYngPKXAYJwFcQnA9mdB3gpIF6RcY243gZv0bA+IjVD9nZTi4be3gcFDnpGCA
	 3DEFVgl1dFC6+Yqy9kp3ayNGvjCeTaBN4z+nP/6wJ3mL0euNu8A8lxAYCmz/rIex3z
	 C4SIc/b89WdVPMi2OFwjvhX9ZvxjbkNCXYGqcj89o+6qa1uy18n7lSlTD9vugF4ecO
	 MoZZ7+4L1zZ+z8DExhgbDWgSDfR5FujfKCm9MfRJzrVY0rvq8oMdYA2sLb7cid38dJ
	 +zXrEhTTr7KPA==
Date: Sat, 15 Feb 2025 18:03:25 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.14, part 1
Message-ID: <20250216000325.GA1688225-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

Please pull a couple of DT fixes. Well, a few are things that fell thru 
the cracks for the merge window.

Rob


The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.14-1

for you to fetch changes up to 038e33fcd40e59b60cdca561c2a39998e6759e08:

  dt-bindings: display: Add powertip,{st7272|hx8238a} as DT Schema description (2025-02-05 12:39:30 -0600)

----------------------------------------------------------------
Devicetree fixes for v6.14:

- Add bindings for QCom QCS8300 clocks, QCom SAR2130P qfprom,
powertip,{st7272|hx8238a} displays,

- Fix compatible for TI am62a7 dss

- Add a kunit test for __of_address_resource_bounds()

----------------------------------------------------------------
Devarsh Thakkar (1):
      dt-bindings: display: ti: Fix compatible for am62a7 dss

Dmitry Baryshkov (1):
      dt-bindings: nvmem: qcom,qfprom: Add SAR2130P compatible

Imran Shaik (3):
      dt-bindings: clock: qcom: Add GPU clocks for QCS8300
      dt-bindings: clock: qcom: Add CAMCC clocks for QCS8300
      dt-bindings: clock: qcom: Add QCS8300 video clock controller

Lukasz Majewski (1):
      dt-bindings: display: Add powertip,{st7272|hx8238a} as DT Schema description

Thomas Weiﬂschuh (1):
      of: address: Add kunit test for __of_address_resource_bounds()

 .../devicetree/bindings/clock/qcom,gpucc.yaml      |   3 +
 .../bindings/clock/qcom,sa8775p-camcc.yaml         |   6 +-
 .../bindings/clock/qcom,sa8775p-videocc.yaml       |   1 +
 .../bindings/display/panel/powertip,hx8238a.yaml   |  29 +++++
 .../bindings/display/panel/powertip,st7272.yaml    |  29 +++++
 .../bindings/display/ti/ti,am65x-dss.yaml          |   2 +-
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |   1 +
 drivers/of/address.c                               |   5 +-
 drivers/of/of_private.h                            |   4 +
 drivers/of/of_test.c                               | 119 ++++++++++++++++++++-
 include/dt-bindings/clock/qcom,qcs8300-camcc.h     |  16 +++
 include/dt-bindings/clock/qcom,qcs8300-gpucc.h     |  17 +++
 12 files changed, 228 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/powertip,hx8238a.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/powertip,st7272.yaml
 create mode 100644 include/dt-bindings/clock/qcom,qcs8300-camcc.h
 create mode 100644 include/dt-bindings/clock/qcom,qcs8300-gpucc.h


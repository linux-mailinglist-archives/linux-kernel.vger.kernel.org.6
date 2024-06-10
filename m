Return-Path: <linux-kernel+bounces-207953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1337F901E63
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C17AB28B49
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D84576C76;
	Mon, 10 Jun 2024 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9yWIQ64"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB8476046
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011957; cv=none; b=pW27xUGFGkXl+5NjbrF9pq8a7euHengY0YpcrbPJL5uOWO26rj4rFZZNecwrb51MndgPoUQQVagBTRuUtGkyE4onMBqojg/9i8rEZKiq3R+VV2zJM7tKMv007GmJ8pH/b+EBFI60pV/4OXb/knxRkXMhTlHLW0K5PTlvvz2IGT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011957; c=relaxed/simple;
	bh=gbarn8HvvnKQ5tWS5o+S1lhLH3zU4Z9+rsEl0g5E/NI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k+soCoOFmb6b569Mipc7Sjq+zGE4/E2nsJrF1ZzbkXm2hGPxxPV+clwFxTjWSe6X+ZIdDWaoiC/xrEXehIKae+NQHIQGl9sKb7TXCJtWwa4azVn0gEkUupkqA20594Wadrwx0E4kQrbnMwgEsrQODRSJRtW5Z+1ESRwTG+UDxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W9yWIQ64; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so83379781fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 02:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718011954; x=1718616754; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J9eIh8+vSpsfiOQcMG0kVL21E4MR+EadTAvkQJKGVpE=;
        b=W9yWIQ64daxN/MGo3ZEYA9QPHLG66/1hHV37WGLg0D/hy24+RmyjM1i4j3dZzguPet
         XzDoUe8W5r0fTtvnHTI+cr5TmobO9o/r0GgdGz0M2EPWVhsPPLko4k97wm3jRdpCBGv8
         t7jBNPXeFlD5Gwe2+Bnn/pAELpFWTUwLpHqt0nTv9m2C6fjGWooJ6tUovjGu55yOF08S
         QiWte9dLL1RUxavMFm7OCCWSq/ILTD/G/h4ODMCv8iYfHHnFfSW8p9B6sZDdWjezbibh
         13V7M9u+dOiFFKfMW2gONN8zB+b3kY6brpwAmRgewH3NMxvUObcS1js9MR6lpoJwB5Ml
         ByvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011954; x=1718616754;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9eIh8+vSpsfiOQcMG0kVL21E4MR+EadTAvkQJKGVpE=;
        b=Qa5JfX1p5PAQ0H89OOYCN7As9n6opfZGjTZxXkswaJkiRsw+fLihh1w0UU6nlgFV4y
         k2ZqWRDC3riOQJmEXQ8sI7W+HVBhDQ6qJyfGnMj2eTMlWDCu3PzQ1G5gZue1nT+DzzpV
         19q3UvHksQV8jgcq0MNv7hlqYuSnvfAn9DMPXGHpSHuoCCyevy80QwhOscDPxFMyYrL9
         1BGnh7aozgbKXiYPokLdj/6aBomdKq5vnGSKj2UWMcaBRw5PcPc1iuy9bKCOtkMXwjEL
         1Z+br9rDoKzfopjUuvCm4zTHHNthfSoxR2S8vwcBOc6o9ScS9e30rB7wvKG0bgPPbddh
         YDrg==
X-Forwarded-Encrypted: i=1; AJvYcCUTlpq8TZJ7zEhjnjXgF+vo8S5Lp0M1Z2yYMdee7huSfyObHMn71+Ie1uPhMVHUEJji1gCacxGERQFl76sc29s2o7IQTbxCxv9Aw64X
X-Gm-Message-State: AOJu0YzCF1UiceviX1LMlkf/vcjiWFbtAOAvwymp2UnN8Aw4FVtaB9jp
	m9tT6LM3RXgaSSPVSiR9i8Nc6CTzfzDHps05+IDcAYmN/Z2yZ3YyR+UWkTFsydQ=
X-Google-Smtp-Source: AGHT+IH6M+gGoxYti68PgMyxeGCDfRspot0JaT6qtD4HXBifKh7SeFc6+v8ZzBU+UfXGDa7EEFw0CA==
X-Received: by 2002:a2e:82c6:0:b0:2ea:9194:ab2d with SMTP id 38308e7fff4ca-2eadce38257mr70167731fa.18.1718011953919;
        Mon, 10 Jun 2024 02:32:33 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c364bcdsm134759405e9.19.2024.06.10.02.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:33 -0700 (PDT)
Date: Mon, 10 Jun 2024 12:32:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 0/2] PCI: endpoint: fix a couple error handling bugs
Message-ID: <6eacdf8e-bb07-4e01-8726-c53a9a508945@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Two small error error handling and cleanup patches.  The first one fixes
an incorrect error message printed on success.  The other one fixes some
cleanup.  Which is probably not required because PCI code is generally
required for a functioning system...

From static analysis.  Untested.


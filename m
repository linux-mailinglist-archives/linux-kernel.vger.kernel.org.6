Return-Path: <linux-kernel+bounces-371345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE359A39DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D44628572B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B20D1E22F8;
	Fri, 18 Oct 2024 09:22:51 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1829C15666D;
	Fri, 18 Oct 2024 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243370; cv=none; b=C8NUlDlAHVR7wKpoap4OHwHdecdb8NdYLSj9u4Tb0nXNy2adhOepT+V7xwtsPomOi9lBhrcgLvRn7LtWqu2fc+n8CufvK2lb6R+SMnvyribYKRYBl+b5tPzZGj58CncGm5j0cpc0EwdbniqP5WLofh83bwW/9JtOuP7f9zMvJwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243370; c=relaxed/simple;
	bh=ZND+pJ3gQC6iceQE4vHCGnD3ShRCYad+p8lWfl/dA/I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WM5+AYrzAkud9fwkJVro0jCMZcXju+O5gRJlJu6LtlVbFI+TDuZApvrZPcr3lEzBH8qazOVgIBWTa2QmW3ujUBWANglWu+sX5Mx/Xd0R/gymBniWz6vjmsePRg05JN4/9DW8yWhXeSplpoyn8SZCVW1RUAQLTy3/vzWpsS/c1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Vinod Koul <vkoul@kernel.org>, Bard
 Liao <yung-chuan.liao@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Sanyog Kale
	<sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 5.10 0/1] soundwire: cadence: Fix error check in cdns_xfer_msg()
Date: Fri, 18 Oct 2024 12:07:13 +0300
Message-ID: <20241018090714.399076-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-03.aladdin.ru (192.168.1.103) To
 EXCH-2016-02.aladdin.ru (192.168.1.102)

Svacer reports redundant comparison in cdns_xfer_msg(). The problem is
present in 5.10 stable release and can be fixed by the following
upstream patch that can be cleanly applied to 5.10 stable branch.


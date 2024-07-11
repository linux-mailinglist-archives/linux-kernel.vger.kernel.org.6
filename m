Return-Path: <linux-kernel+bounces-248530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE3D92DE7D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE2D284217
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941637441E;
	Thu, 11 Jul 2024 02:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bFxF9IyQ"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD9D381CC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720665361; cv=none; b=rLc3seQjrbJOCxwAiGw8anvgHjQzNb4QAHaCM/IbTzoXhPpfb5cKSUB/29E6jk+kI3VLZ+ttemtn9SLnGy3fzNSISdSkvdbtyU+TCrYu5C0So39pheeqcPnHoBVHSSjaE2jQSrhb2ZrWoAjQ80JXvlCGimj7E0GjKF73mniXJno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720665361; c=relaxed/simple;
	bh=zzY09uwiZCWnLQXxP0T14GZnXHH/yHd4Y6I2NVImWQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLWO04WYdwUT25JtyYsPqT86K/RRBDGeaQwHpKEIxENWCSWRA2Z+G8eaFKPwxoEk8lv4Kjb5JvF1c6SX2062W4ITaGEcmJbrNVShlRPDqijGIdCV9EXR1UEnmbUfK6MLnIBpflk8GBHwSy1TN922pM5XZUEfZSGMmpe6PuEcvzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bFxF9IyQ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-79.bstnma.fios.verizon.net [173.48.116.79])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46B2Zh84025452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 22:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1720665345; bh=RbMgvuiwVaWYPFN5IWCg3KEps9TEsABTJ1+PkN4kwXU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=bFxF9IyQHWW8Ep9Ev3cwzCjonPYPnevzm5YY1YWHeF7oCG0iSnCG5AGEvmXg2tFOd
	 MntAu0CYussS98MDxV9ESvf+ATmE6b4DlpG/MwyNh9CvXUGCz1HOgnuyli/+aUuul/
	 dd1wjmdCMSQOV1x7WfVRh04SYUg1gDZyaJNS+r6DKudE9Teqc/7NqqrFTUvIu/M/5O
	 T5ISIhbTwIjZkfPGT+zF4ZqkpMGZEugxK+CSBFhN7WUNRWNwi9cpvWpn5AMDgQ8vSy
	 c/G47UZa3ZTsy46XpVtSxc750DqXRCi6U7YLGvePvuXnTcLjRHWI/T7LopXFJEWWMz
	 ZhVPlwaZr/Xlg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D6CF515C1909; Wed, 10 Jul 2024 22:35:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.com>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] jbd2: add missing MODULE_DESCRIPTION()
Date: Wed, 10 Jul 2024 22:35:35 -0400
Message-ID: <172066485811.400039.17458022104196002091.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240526-md-fs-jbd2-v1-1-7bba6665327d@quicinc.com>
References: <20240526-md-fs-jbd2-v1-1-7bba6665327d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 26 May 2024 11:53:49 -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/jbd2/jbd2.o
> 
> 

Applied, thanks!

[1/1] jbd2: add missing MODULE_DESCRIPTION()
      commit: 89a8718cef859091239fa60b4b5749ecea93f55d

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


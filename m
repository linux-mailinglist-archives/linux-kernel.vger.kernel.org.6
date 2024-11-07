Return-Path: <linux-kernel+bounces-400163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F0E9C09BD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973881C21634
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0591C213133;
	Thu,  7 Nov 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="XSUZSeGZ"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACA1212F08
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992399; cv=none; b=oX+A1e3RgUuJBhPVNl/O2QEdQ2fO7VYq7rRr5i2GcvOL7YRb0xd8vcWPHa9BEv9hypVYP/El0jV2nRTTZiJRcQI+9Q3OWybbx/549PAuZ49EFTSlGJNmgpsHuICp2oLeSLMHIB0nu8jyd5VNv0vkeYM6XPu8e1nHwhsNO9uAFY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992399; c=relaxed/simple;
	bh=HcNHhFfTShWTzKzfY/uhw4hdIdh+uMzQeWG6b/6X7G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgacvdAo5MmMW2BFIBzvlnbUVVLW4RpykE4xVCbKzDWA9zW/bFelvEv3A5us9DsNqneUzNIv+XuvFs06mJME7AGkC/b6Qm84WcTN/akSHcZAP8Nz/0E0PLAAI5BbAICBj9Ov78pp05TpHB4eFIFMEsw8SYl06vmVWs6TFALK6Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=XSUZSeGZ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A7FD8sc003574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 10:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730992390; bh=KwUQzYi54I4Ym1o1S7slXAKT2+zFfZ/mdrrjh5gTS+8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=XSUZSeGZEJiYyPAwIk4xerseKuQnNr0/q1jQ85X5Be308hZT4aenXS2J7AXI4iiMC
	 bnYp5cDXQLso+9xTaGGLWhlrX6gBxc5gJq48S2ci8kGNWd7JjZs3cD8e1mJIVgbTet
	 gFU1SQTtAgbrhjQ+xohMB5ucNOxdEAVCGjc64oZ6UBICR3fSnHqsQTpTwgtoRi4gPM
	 7Z/Hife4RZA7UUWXjuXM/yGYfUJXr7EWtb9dtVkDQTkHU7wzDj/f/LliOBr4NiqNVf
	 nS2GatAma3miIbxnyZmydXY7tMspGgRj1SPVTrRjCExvw8OaW6H5GV4tCI4mbJH0KF
	 UuCnAOB6Xc/SA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 50DB615C1DE3; Thu, 07 Nov 2024 10:13:06 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] ext4: Use ERR_CAST to return an error-valued pointer
Date: Thu,  7 Nov 2024 10:13:02 -0500
Message-ID: <173099237655.321265.11627437788240292655.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240920021440.1959243-1-yujiaoliang@vivo.com>
References: <20240920021440.1959243-1-yujiaoliang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 20 Sep 2024 10:14:40 +0800, Yu Jiaoliang wrote:
> Instead of directly casting and returning an error-valued pointer,
> use ERR_CAST to make the error handling more explicit and improve
> code clarity.
> 
> 

Applied, thanks!

[1/1] ext4: Use ERR_CAST to return an error-valued pointer
      commit: 046c72654ae5660746ac8ce10c534d99ae35cf4f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


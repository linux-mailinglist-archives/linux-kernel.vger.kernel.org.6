Return-Path: <linux-kernel+bounces-409397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9F39C8C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D4DB316B5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BEE811F7;
	Thu, 14 Nov 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="cBPoxYX/"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA58A558BA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592442; cv=none; b=kbBEUuZA9ucHAugZKp/vm3l9OkeznYPn2BZS20FJdT+TZU1bAKadc9q4pz/7qD+8RCHiBylDbZBm2vLSND9JlIHAxk1hZG3z1Y4ckL84pcwA0dWhyGlpQIyVCg50kzra8NQuN0P9fI/1BCgjS1OC8nYNIULl06OvpRTK+FhGbuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592442; c=relaxed/simple;
	bh=L22YgOu1UgYfx6yU71GzYdLVSG8mo3DtRChzf/YhAvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGVjVL1i9HZglhf0ObnsHxoFB6Zp9PNmtgSYeShdTA7IzCUCxj5CRWo+vVnySn9pHUeTGLY2x+rZKgH3kAclOeTqBPbkyrRLcjlachGdlALPIuE1mnR8PCEXPMpRqNCY+xThCsxqUIHoQ+u0dvuD3T+Qs19m0oVyeXq/Qx4WyIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=cBPoxYX/; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-132.bstnma.fios.verizon.net [173.48.113.132])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AEDrjSD001834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1731592427; bh=cm8FyW8++apwJak7SylvAXigqaGb6oXHmvYVmGc0/Mw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=cBPoxYX/0uBajMwtC4FHf5RWSeCTsUUKFvAuYn/iVJA5/2Pqsl9jwr1Ik5ItbKMY5
	 uzy3/Zrl9Nqg485Za0Clc/Fo5OzFbTeqPsYxBi1P6uHSocrdfsgIe6pSuaM9N5T8TZ
	 Mz4fx/LRnNDZFUP+Ex2cqf9av6GDVqdrF9kfYTEeGOwaZx0lcBUREhXGufS67wSV6t
	 ce1kyw1S+KIoUa3iQvLHqhgWgUdvuX3XzLnislA75DVFSl0U5afLe+th6OMraqw3ik
	 hRD891TdDJgoCituMAVEuLoshS0RXH+WY4lUCQrochEXeA5mUthxKgcqiXkWlhZ5pN
	 aQDjkh1JrnyrQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4E34015C1DE3; Thu, 14 Nov 2024 08:53:43 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Use str_yes_no() helper function
Date: Thu, 14 Nov 2024 08:53:39 -0500
Message-ID: <173159220756.521904.6103415449377192729.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241021100056.5521-2-thorsten.blum@linux.dev>
References: <20241021100056.5521-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 21 Oct 2024 12:00:57 +0200, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_yes_no() helper function.
> 
> 

Applied, thanks!

[1/1] ext4: Use str_yes_no() helper function
      commit: 6a0c5887a54318eaaafb00825ebb10d1f7c8f0cf

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


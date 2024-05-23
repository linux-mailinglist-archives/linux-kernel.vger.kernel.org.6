Return-Path: <linux-kernel+bounces-187798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CCD8CD8A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B32281DF1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F7839FD0;
	Thu, 23 May 2024 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="kcl3eoyE"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13420335
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482743; cv=none; b=sZWDZBeCkwgw7eZM1EKbr2wp1ukfmo8K7VHfgdW/ekkndHzdBl39V8XthcG2tEeoivdzdyYu/osGnV7Ns0qsGAH3EYC+knu9T23zHoHXxH+6i7LZ9gic+G/Ni+gBLlcy5X2psGBnW6H899lkDUPRJpGzSXWvH8hy3jQ4CobLF/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482743; c=relaxed/simple;
	bh=PeE2Iv1cUElnBiThT4jIFU1ihOHGm8Z1qxGwKgRJTAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWeoJ76vo3OMB4EfrsWCDyhpJp8V0T9yatO92ipAzQnhkeGy7coijK+kjALci/M9OVt5zVZtG5ktfOZuMJCVT5MP8D6lPVwjofsFOvlZ5GZbdfdamN8ko+A4gAIgTAjqk81aNGn2DEZGX/BqlW5X4XMCIG+WUTsArR4D+LWx6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=kcl3eoyE; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-7-50-195.bstnma.fios.verizon.net [108.7.50.195])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44NGjJlI031728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 12:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1716482722; bh=76A2SchJx/XQs3JI5IruaZJ74cXb24Hwn2+K3+4a8+k=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=kcl3eoyEwTqIqwlQ+1yfhnlEuUVOR+ebptXPpIwcNZjZxh0DsqTXIH+B4SMWoy3YU
	 Jvjy4Lf4duH+yEuQMuLMdZOn1t4IHxW3RtrizNYNv9fbpjKRIRPOpke6chKK7V+nAC
	 WTec0mnUr5r9cQ2lbKiPBPUKCFBuTTJyNi/IRMjLo/QuNmpFC7AmR2UoAIRhdS8SGu
	 gVoGr2bSAea3BqQC3rb8TO+FwVp9j8y47UZ+LgdltsylDRxOsLBf0A5sEuul9U6KpF
	 LbzdLJh/sn34Dv8tqLVbMnbIRi/M8a67AF//y1wElGyqRF/63QrgnPZ0L/h4N4w4hg
	 p8xss9mQEH6Jw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 9E62715C0225; Thu, 23 May 2024 12:45:19 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Matthew Wilcox <willy@infradead.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext4: fix error pointer dereference in ext4_mb_load_buddy_gfp()
Date: Thu, 23 May 2024 12:45:16 -0400
Message-ID: <171648267844.923789.4231199989954274163.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <eaafa1d9-a61c-4af4-9f97-d3ad72c60200@moroto.mountain>
References: <eaafa1d9-a61c-4af4-9f97-d3ad72c60200@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 10 May 2024 18:22:53 +0300, Dan Carpenter wrote:
> This code calls folio_put() on an error pointer which will lead to a
> crash.  Check for both error pointers and NULL pointers before calling
> folio_put().
> 
> 

Applied, thanks!

[1/1] ext4: fix error pointer dereference in ext4_mb_load_buddy_gfp()
      commit: c6a6c9694aadc4c3ab8d89bdd44aed3eab1e43c6

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


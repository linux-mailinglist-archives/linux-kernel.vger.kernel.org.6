Return-Path: <linux-kernel+bounces-400164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A645E9C09C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5CB28555E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FF2214404;
	Thu,  7 Nov 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="UCHJMUfD"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54858213ED3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992406; cv=none; b=Klq0God+AhOy1hfO/FgSxwVZydObVyieXdaV0KVul0NkEM8BSvOaV10lAuPdfaGVw5MHVTD3H6R6NBUK+wZZoVgXErr8NTH503hsNS8jpXGmoPBFNRDrZ7t697saPI5MDTjCVbyAakRY3NmQmfolg+lCmKfPzN/rSUg+MQYQk5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992406; c=relaxed/simple;
	bh=FT6MnmzeE6WjFXu2y0qctXlMQGh2sDxwyNY67mtkC3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IK4Fh4bsTyQAzozV/sDgsPy0XTXCyeZ55GyF+yGqM0DG4J6poQYB8CkIbv+KLWGVB+4Nz7C4WUqFZAyaE/2/+mvRi0w6UYd6H1vCVaCiCVl+qWxjwios5DFj4CCqlt9pPdUm6Km7O6nMkV21ZazzTHPME+pxt5Yx0rffEf1zfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=UCHJMUfD; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A7FD6pu003525
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 10:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730992388; bh=TfPCqtyxrPsov2ZfLXIh19nQcYzczmBp4OXtEdoM0Dg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=UCHJMUfDyxOBZwtMVfnAuSyDsEapSUxnXRMW91IyPbn2Tg0hHrhwYF92ze5JRdwyB
	 GTHCLGmHF3JnWMS0oN9hL4ib4VQmTDwRpFop+MTf+OffsHjphR1ewNbou0KEIKWkqy
	 GNvGBSyHbqHcKQl8yJsUQTSVPYmgcnlxDzUzkXrJ0aM/gRqg5sMtQvFhbFahzd0Ckd
	 L/LFRLZSaXrIKXsU/LiaOXdArMK3gvanYH+leI7ICHZFYfoQH+hMo6/Zbf4/aJMSXz
	 mOnGWvFZLxBpoaR2tJDU9O25idLrqo7xwPYhAiu5Iea9s/tq3qVuJlwA+Z9/54mRho
	 j03XmI+m9ftxw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 44BF015C0333; Thu, 07 Nov 2024 10:13:06 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] ext4: Simplify if condition
Date: Thu,  7 Nov 2024 10:12:56 -0500
Message-ID: <173099237651.321265.12505050790055493032.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830071713.40565-1-jiapeng.chong@linux.alibaba.com>
References: <20240830071713.40565-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 30 Aug 2024 15:17:13 +0800, Jiapeng Chong wrote:
> The if condition !A || A && B can be simplified to !A || B.
> 
> ./fs/ext4/fast_commit.c:362:21-23: WARNING !A || A && B is equivalent to !A || B.
> 
> 

Applied, thanks!

[1/1] ext4: Simplify if condition
      commit: 296eb810fa1f346f3a1eae46504459a3f81126dc

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


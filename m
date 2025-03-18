Return-Path: <linux-kernel+bounces-565401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2307EA66793
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049643B0B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2A51B3922;
	Tue, 18 Mar 2025 03:42:07 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B631A8F9E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269327; cv=none; b=tXXW1poDODqow2s+g4dlu6PL4YQuc1HIDC35rBJMXJwghPKVP7MGiYqM4TEmohZ0IX47Kt9+B9kUEYt1rnRz0Tp3XCZ3kxIFfj9/zO9UVeOgImo7aYio11fwb8SHpGjShudR+AgNf4VU1PRgA8IqwGgGlpFO5ue/T2yVlQKcCv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269327; c=relaxed/simple;
	bh=U+LtcT0zsfAgse4AYQMBr+iY4Hfn5dwICO6vNn8fUuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcMp40PfZrrtMjai1mDWN/11q4WO0FwVtRePFcqFdtkHGcMaf0csZCWuvXpS8B2QS3iXo+4v/lAS682JwY7sdBWStlBuic8LcILFGXBqxDByVVMZCh4ZhPfbbe4A54tNiir+WraVHs6ABnbFl4bzK424RBAxqiEZmfSWnBtMepo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fm6o012150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:49 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E6FEE2E0116; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Diangang Li <lidiangang@bytedance.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: clear DISCARD flag if device does not support discard
Date: Mon, 17 Mar 2025 23:41:24 -0400
Message-ID: <174226639140.1025346.17209079713890746591.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250311021310.669524-1-lidiangang@bytedance.com>
References: <20250311021310.669524-1-lidiangang@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 11 Mar 2025 10:13:10 +0800, Diangang Li wrote:
> commit 79add3a3f795e ("ext4: notify when discard is not supported")
> noted that keeping the DISCARD flag is for possibility that the underlying
> device might change in future even without file system remount. However,
> this scenario has rarely occurred in practice on the device side. Even if
> it does occur, it can be resolved with remount. Clearing the DISCARD flag
> not only prevents confusion caused by mount options but also avoids
> sending unnecessary discard commands.
> 
> [...]

Applied, thanks!

[1/1] ext4: clear DISCARD flag if device does not support discard
      commit: 1c81b7fbcea9ba75f059dcd1ed4c94543593378f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>


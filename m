Return-Path: <linux-kernel+bounces-383549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85019B1D2E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 11:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA28281E01
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C526E55897;
	Sun, 27 Oct 2024 10:15:58 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF128399
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730024158; cv=none; b=GUvJcM8knlnaIwOOp1CjMtlQm6bq+rFA3pAiOJuGyf4UqwEORyQqdTHr1uzHPscIhcpCK2XX/nxXY/JYs3jnlTQ1nfrAVe7Rt+rTPWGSMtn0RmlKkBV3Jvdc4ILXsPAwfx5dVzfkcGD9Hf7QWMHaiFLV/6A0g/yBi5y9xUJgNYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730024158; c=relaxed/simple;
	bh=DJp3snN+MjrzMKbj4qDCvaOixg1tJT7RN2R6aoJet1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hUaHH2vnxZeiW7h34W7GfEiV7ltNOHz1vCJ6ztFXS0x9f6Nx4PbvXgXmAK/cdGRVBeKB1jQQZdpgRkwm/z17XfE5EEASIhF+ByStj1Bdl7pIpUBfdr+GAG11Ts2IrLjP1X7ST3ievxgoFur8yWLzv6Noj5b3emcrOkgDvJU4vM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 49RAFgZR096357;
	Sun, 27 Oct 2024 19:15:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 49RAFXS1096267
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 27 Oct 2024 19:15:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c0c37c71-069c-4fd7-8a71-083a68f6c0f0@I-love.SAKURA.ne.jp>
Date: Sun, 27 Oct 2024 19:15:33 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] KASAN: stack-out-of-bounds Read in profile_pc
To: syzbot <syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000030293b05c39afd6f@google.com>
 <0000000000008e5b5e061e96a171@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000008e5b5e061e96a171@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp

#syz fix: x86: stop playing stack games in profile_pc()



Return-Path: <linux-kernel+bounces-395020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F589BB738
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E7CFB23B03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB2E13B2A8;
	Mon,  4 Nov 2024 14:09:36 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CDC4502B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729376; cv=none; b=SScnFgKLgJXOMo5ObZwwzLZHBDCUsZvq09ld5j3HGkdrv8a/FwNIBwbBEGNoPCUXQzjNtq1/B4LP/aTQGSeNYeWvW1BILUSvlegzn6C7yJfJdSr9yw0+4gDQMbQcHQnxF8mAB6NAlnNVPjFZKE5CqRyq04F6UINZs6J8ymx87KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729376; c=relaxed/simple;
	bh=IP/LGqqkDP0Ny4tl0Scl7iV4uJRPc+S7Om5+3u4QWNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vx++K8D/4kly+wLVkBNDpLLdLddLyKOHtIyoLVSkkPD/yaEIKhSqmZqtozHqVOIEpu8kWNVjnfyt0eIbWfVJkNgq4LONmYNjtwTZmPp5bbPnZfbOg+BzULAqo50ZqeVBKVsszN4bIpAfT42I4b4GklYT5gjdQy/WK3MxteSk/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4A4DBMb2049324;
	Mon, 4 Nov 2024 22:11:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4A4DBMs6049319
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 4 Nov 2024 22:11:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ee2f3374-5650-4f09-8e52-0b94263e8fb8@I-love.SAKURA.ne.jp>
Date: Mon, 4 Nov 2024 22:11:20 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] possible deadlock in lock_mm_and_find_vma (2)
To: syzbot <syzbot+b02bbe0ff80a09a08c1b@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        "Kirill A. Shutemov" <kirill@shutemov.name>
References: <66ff2ead.050a0220.49194.03ec.GAE@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <66ff2ead.050a0220.49194.03ec.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp
X-Virus-Status: clean

#syz fix: mm: split critical region in remap_file_pages() and invoke LSMs in between



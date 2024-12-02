Return-Path: <linux-kernel+bounces-427031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B231B9DFB69
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E60BB252D7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71FA1F9A94;
	Mon,  2 Dec 2024 07:43:08 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110E81F9A8F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733125388; cv=none; b=bSawe/aqgkeO782fYJoB1KoEazqUREDbaZHKsA+r0Uzn9KF0RzKHHXiOCSjsNCAhPK/3xFdub9nok71Ik0fRVAQxOoB9rqU5yZE+3rX/ASgkwpoFGGBRzrNYIdoAm3s9iB9O7YC3D2WNGjmdYFbxNBBCF/nY7DN7Fl1kSkEpg2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733125388; c=relaxed/simple;
	bh=gn9+hu/OEaazsVovWtDoflu9CkOoUNzZ5rEdvlBjVHE=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OUjkES5mKSSy3ZBa5Ww7wZ3wwegDUQyxdV3uwwKXHc+aSrejzjyhzp0surhKVAlFk590sdkBa2qmZVIrO8R6dtUiRXm+u3KW51ZvHSL1w8d9YJNKovldXyL9sOG4cvuD6iy+DIUjNQGM2P5hb0WcMiw9ac6oXQnAqt1kbfYqjAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx364FZU1nHHxOAA--.47543S3;
	Mon, 02 Dec 2024 15:43:01 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxtsAAZU1n78lxAA--.54582S3;
	Mon, 02 Dec 2024 15:42:58 +0800 (CST)
Subject: Re: [PATCH v4 06/10] objtool: Handle unsorted table offset of rodata
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-7-yangtiezhu@loongson.cn>
 <8cb35ab7-56d0-8e8d-5e18-1bc2b94aeeeb@loongson.cn>
 <20241127012042.by4g34m4twlfmove@jpoimboe>
 <53677c5f-2ea5-a227-66f7-b27c27665f6b@loongson.cn>
 <20241128001011.sjedpn2zhrhy6y6i@jpoimboe>
 <20241128001627.5czdlst5rd76qwsd@jpoimboe>
 <20241128010034.u3b7gkh4wqgb7d2s@jpoimboe>
 <19af5a40-9bf7-bab6-2a69-02fba652a7df@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d275de88-41d6-b766-4a82-b9c66e14db28@loongson.cn>
Date: Mon, 2 Dec 2024 15:42:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <19af5a40-9bf7-bab6-2a69-02fba652a7df@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMCxtsAAZU1n78lxAA--.54582S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKFWfWryfGw48GF48XrWDGFX_yoWDZwc_Jr
	y7uF1UCws8JFy2ya4qqws5X34kJa4UA3s0qrWUXr17J3ZxZFZ8GFWxGryF9ws0kF93Zrs3
	GF1aqF4YgrnIgosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
	JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2MKZDUUUU

Hi Josh,

On 11/28/2024 10:28 AM, Tiezhu Yang wrote:
> On 11/28/2024 09:00 AM, Josh Poimboeuf wrote:
>> On Wed, Nov 27, 2024 at 04:16:29PM -0800, Josh Poimboeuf wrote:
>>> On Wed, Nov 27, 2024 at 04:10:18PM -0800, Josh Poimboeuf wrote:
>>>> On Wed, Nov 27, 2024 at 03:01:33PM +0800, Tiezhu Yang wrote:
>>>>>
>>>>>
>>>>> On 11/27/2024 09:20 AM, Josh Poimboeuf wrote:
>>>>>> On Tue, Nov 26, 2024 at 09:28:19PM +0800, Tiezhu Yang wrote:

...

>> Still talking to myself here, I think we'll only merge the above patch,
>> since we don't know what the generic annotations are going to look like
>> yet.
>
> OK, my next version will be based on tip/objtool/core after
> the merge window, by that time, hope the tree include Ard's
> and Peter's patches to avoid conflicts.


I need to rebase my patches based on tip/tip.git objtool/core branch.
Could you please update tip/tip.git objtool/core branch to 6.13-rc1,
and then merge jpoimboe/linux.git objtool/core & objtool-loongarch
branches into tip/tip.git objtool/core branch?

Thanks,
Tiezhu



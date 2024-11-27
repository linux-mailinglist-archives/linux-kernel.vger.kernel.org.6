Return-Path: <linux-kernel+bounces-423833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FA89DAD68
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B93F166410
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798FA201254;
	Wed, 27 Nov 2024 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Go5qPiJq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85DD201105;
	Wed, 27 Nov 2024 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732733585; cv=none; b=fjwlYy8dlmgocrZopxf1DIye0PI9V+sYvx3iQ0cDqKEZFZfklV0a7nfUB1KzzKrbqrd1vRA5A+4BExTbD0ZQoryrt8ClV7OpGro7thr9y/JaXjYFvDHKLfEpmDAYyckNEh5G5FYcQOA8zCKCXkABF9YavZX2q/jJlnOKlY+jtZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732733585; c=relaxed/simple;
	bh=BqL09I5bjX+5UXyYYNk30hCn58iZqzaW8RyreYtcjsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W013zIhx8cMn2YXkv+jHVZE6utib0lToktCElQH9CRd6s3lEX5Vg4a4w72O8H0jCAfRcWefWd3gkuqyzmVPFMspHHT0Pi9JrmWKpvAK/DeNhjDynM1J9P0wXPYpNrhRTxerCZk0VZ1P0iLFhJ6/Am90M5V53PBIyJF6fSTNpYjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Go5qPiJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881B3C4CECC;
	Wed, 27 Nov 2024 18:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732733585;
	bh=BqL09I5bjX+5UXyYYNk30hCn58iZqzaW8RyreYtcjsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Go5qPiJqHddWDw7Ijsoa7lzxQQOLBA7tckcOqAAByi36H83jtMoR6UAWLTmMaRMPz
	 3YIC444K8bYlKTRmemXpNS7qC4GgU8Cpor9MBZ15aDmMI1mR3g5Hq5MF4f6uXasgQG
	 fI906/LPG+2QCGf4L5kUlgHtf8sVEnA/mmZ2QNvEFkM9Rq8AQQ339IhB1TdnZmK26A
	 Dt9fnSYLMcsPfxf4y/K2271/LiN20WmQAqIDtWYmT8LhR1TVOhT6xpBqp9BCk95OKx
	 JHdO+rmnAMCLeQMNaQuNTUT9qbzOKss1CuOvTi/WciV7F/THGMDCL6Qdh5I8Pcbxar
	 cjXVdZkOFbOcA==
Date: Wed, 27 Nov 2024 10:53:03 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/10] objtool: Handle various symbol types of rodata
Message-ID: <20241127185303.q6okbtrkfdrlmcrn@jpoimboe>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-2-yangtiezhu@loongson.cn>
 <20241126064458.7ugwqfx5vhnwzvbi@jpoimboe>
 <75f6e90b-4d04-5627-395e-58982a84d7c1@loongson.cn>
 <20241127005208.luhtjy2qhk3bza7a@jpoimboe>
 <f1bcff28-dc9c-2878-10c7-6e653516e66d@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1bcff28-dc9c-2878-10c7-6e653516e66d@loongson.cn>

On Wed, Nov 27, 2024 at 02:39:13PM +0800, Tiezhu Yang wrote:
> On 11/27/2024 08:52 AM, Josh Poimboeuf wrote:
> > On Tue, Nov 26, 2024 at 06:41:29PM +0800, Tiezhu Yang wrote:
> > > On 11/26/2024 02:44 PM, Josh Poimboeuf wrote:
> > > > On Fri, Nov 22, 2024 at 12:49:56PM +0800, Tiezhu Yang wrote:
> > > > > @@ -2094,12 +2095,19 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
> > > > 
> > > > 'prev_offset' needs to be updated as well.
> > > 
> > > I am not sure I understand your comment correctly, I can not see
> > > what should to do about 'prev_offset'.
> > 
> > Further down the function there is
> > 
> >   prev_offset = reloc_offset(reloc);
> > 
> > which needs to be changed to
> > 
> >   prev_offset = offset;
> > 
> > as part of the patch.
> 
> If I understand correctly, reloc_offset(reloc) is different with
> reloc->sym->offset + reloc_addend(reloc), tested on x86 and readelf
> shows that their values are different, reloc_offset(reloc) is the
> first column of .rela.rodata, reloc->sym->offset is the second to
> last column of .rela.rodata, reloc_addend(reloc) is the last column
> of .rela.rodata.
> 
> If do the above change as you suggested, there will be some objtool
> warnings on x86. I think it should be:
> 
>   prev_offset = reloc_offset(reloc);
> 
> rather than:
> 
>   prev_offset = offset;
> 
> That is to say, no need to change "prev_offset".
> Could you please check it again, please let me know if I am wrong.

Sorry, I was confused by the fact there are two different meanings for
"offset": one for where the relocation is written, and one for the
symbol it refers to.

How about instead of 'offset', call it 'sym_offset'?

-- 
Josh


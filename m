Return-Path: <linux-kernel+bounces-422932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D579DA01B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 01:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D81628372A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFA34C62;
	Wed, 27 Nov 2024 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xh020b9J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E9F256E;
	Wed, 27 Nov 2024 00:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732668731; cv=none; b=PZ8r+6XwZFpw9fAL2Yaigo2NuS46LGHDXXqXbGjjYryYHLb1MxWOhTwEzQ3wxEZ1VZ2s5VLX8fccHaHiCWkjrdwD9IZqXBeCjF4s6/pJc7EYdejyctThVaA8rixPperTlblz4Cs5WLjeSTNmssmtzNzH8ZHcm5G0ST2ZbzOzkSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732668731; c=relaxed/simple;
	bh=OaaWybiW7urxODpibZjwOzZSOY4qMP70ycnoImmxaNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKFf5QTfeMzc0xJJ9sxrtnN/I2eB5kNu3HZSPUU3HTigQqHf0IsAIXsk1hvY4IX3wkGYqA0yroImxEN/kLAv/V2bdqxeHTZ5rVH4Cyfblgw3jfgHnlu8tPy4I3ABvtSkFXU51g0b7vM8M4w14rgwFVO8qh4ijTj+NyyBbDiI2S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xh020b9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD32C4CECF;
	Wed, 27 Nov 2024 00:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732668730;
	bh=OaaWybiW7urxODpibZjwOzZSOY4qMP70ycnoImmxaNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xh020b9JGnL7qEeoX0JKCmMuTfmjYS9kCaKALP3jqPnfdlQ45xqEEsof09FYrb2Nq
	 ZjngsUF0fn9WS5rNaEL8z/RWZfybynB/yXW3krgjg3qKYwet7+2C4+6fPyUegi5cWC
	 9MO30+woo1RLHHObxqQB9lLKyX3QISn4NiIDPVA4xdj+YMNmN3lHKWhtAoLap6sIuw
	 esACuL9dmV1iJJaBpEKIdtBn00UQkZmlIY97tdsfT5pzjrWyPwX2m/oo8r9r6OLILF
	 cBB77+VS2WE1dOS35vANaXKgiuJwyY3QdsvkeLVXEmBaQH7xThlBmjziWJVbTggHoT
	 T77VcjzjGgW8Q==
Date: Tue, 26 Nov 2024 16:52:08 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/10] objtool: Handle various symbol types of rodata
Message-ID: <20241127005208.luhtjy2qhk3bza7a@jpoimboe>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-2-yangtiezhu@loongson.cn>
 <20241126064458.7ugwqfx5vhnwzvbi@jpoimboe>
 <75f6e90b-4d04-5627-395e-58982a84d7c1@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75f6e90b-4d04-5627-395e-58982a84d7c1@loongson.cn>

On Tue, Nov 26, 2024 at 06:41:29PM +0800, Tiezhu Yang wrote:
> On 11/26/2024 02:44 PM, Josh Poimboeuf wrote:
> > On Fri, Nov 22, 2024 at 12:49:56PM +0800, Tiezhu Yang wrote:
> > > @@ -2094,12 +2095,19 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
> >
> > 'prev_offset' needs to be updated as well.
> 
> I am not sure I understand your comment correctly, I can not see
> what should to do about 'prev_offset'.

Further down the function there is

  prev_offset = reloc_offset(reloc);

which needs to be changed to

  prev_offset = offset;

as part of the patch.

-- 
Josh


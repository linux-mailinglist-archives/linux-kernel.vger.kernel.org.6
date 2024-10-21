Return-Path: <linux-kernel+bounces-374770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04399A6FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250811C20993
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B05F1E0E0E;
	Mon, 21 Oct 2024 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="a9x9op6z"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A867F199939;
	Mon, 21 Oct 2024 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528607; cv=none; b=TkwuXUQVdFWXS8XE17qXNdVodlU2YjC2EZMAPkgaeUlu8BGVOjgMP7IbwX9EGRPJhWFOYZeNjsKkAgzWV7zTeXi1CvrAiALyRkuScY37wroiRQLtQSDoi9nqmZkS4sYIUpkqT9CXVSsT2j3XybyCoulGRZ65NG9ohgmyVuIDvwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528607; c=relaxed/simple;
	bh=XuuGobw0hfMVMmCTBZKSUa46Tfsbw6R+AJV4pdFgx6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q6w6xQYZlPNX0PNC8pF+JFLaCtmkGxbX1thFN1kct5sjP+x49qaQ3hqgDRgWJddMpAXXhvk93ppA+cCLZWf5hUHWSSJEDrEswyMxzD3BOM/0o6boAtsmuFHzN79J5Ycb54oCvYiFyhL7Lq4x+Lz/HUxTgJR9+5K4uAUa7pbPDXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=a9x9op6z; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BE20542B3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729528603; bh=kkS3fy90jciUzgDpVmMX47FSMiXqhw+lNdT1LNHH8mQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=a9x9op6z1qpevV34J9312DUqgryyzZveELlBtjWPRkqi5pPPA2wm0Hcasqo4WS4ro
	 fhrTcGmVkW7/GImVLQ09nySRbNHMzAdnE/YkQAxT6/rwcdaDiMXDyKMxOyE2k0Bal+
	 VR5HCMCK0syfMjzfLTRFMyzpaX6MlW3D/YCc5kTfUdZXQlsFZNH7g7GoZe0ltJIaRw
	 zfxHzFZbCnyLz9HTIwYzHav0eAoZT0yeT7oi81rzIVtjbDAFjztVq6f72i1mZlspVs
	 7xesrYZXHv+J4OTxIIrkwcBPupqA0/VZs6QC7w+XwGMUTUTI9GFe1OQuk2LFIZZTe8
	 UpzicWbS+60Gg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BE20542B3D;
	Mon, 21 Oct 2024 16:36:43 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, Alex Shi
 <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v2] docs/zh_CN: update the translation of
 process/programming-language.rst
In-Reply-To: <bae3c59c-39a5-4daa-b37e-bbf077d57643@hust.edu.cn>
References: <20241018015226.3786020-1-dzm91@hust.edu.cn>
 <87ed49tqia.fsf@trenco.lwn.net>
 <bae3c59c-39a5-4daa-b37e-bbf077d57643@hust.edu.cn>
Date: Mon, 21 Oct 2024 10:36:43 -0600
Message-ID: <87wmi1s99g.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> On 2024/10/21 23:38, Jonathan Corbet wrote:
>> Dongliang Mu <dzm91@hust.edu.cn> writes:
>>
>>> Update to commit 0b02076f9953 ("docs: programming-language: add Rust
>>> programming language section")
>>>
>>> scripts/checktransupdate.py reports:
>>>
>>> Documentation/translations/zh_CN/process/programming-language.rst
>>> commit 0b02076f9953 ("docs: programming-language: add Rust programming
>>> language section")
>>> commit 38484a1d0c50 ("docs: programming-language: remove mention of the
>>> Intel compiler")
>>> 2 commits needs resolving in total
>>>
>>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>>> ---
>>> v1->v2: revise the script name
>>>   .../zh_CN/process/programming-language.rst    | 78 +++++++------------
>>>   1 file changed, 30 insertions(+), 48 deletions(-)
>> This one adds some new build warnings:
>>
>> Documentation/translations/zh_CN/process/programming-language.rst:44: WARNING: duplicate citation gcc, other instance in /stuff/k/git/kernel/Documentation/process/programming-language.rst
>> Documentation/translations/zh_CN/process/programming-language.rst:51: WARNING: duplicate citation rustc, other instance in /stuff/k/git/kernel/Documentation/process/programming-language.rst
>>
>> *Please* be sure to do a docs build before submitting your patches.
>
> I am sorry. I am not sure why I miss this warning. I should strictly 
> follow the rule - make htmldocs and checkpatch do no trigger any errors 
> or warns.
>
> A simple question: if you miss the warning in one `make htmldocs` 
> building``, you rerun `make htmldocs` and still trigger the warning or 
> just the warnnings do not appear until `make cleandocs` is done?

Sphinx only rebuilds what it has to, so a warning may not repeat if you
do not build from a clean tree.

jon


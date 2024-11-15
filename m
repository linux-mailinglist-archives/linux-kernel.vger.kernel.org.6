Return-Path: <linux-kernel+bounces-411419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC8B9CF90B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BE31F216C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 22:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141E21FCF57;
	Fri, 15 Nov 2024 21:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="s+kVdP3+"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47991E1C07;
	Fri, 15 Nov 2024 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706372; cv=none; b=DR/t0CgkPyt5xNZAEJXo3oqxRgegf7+qFJrmtwuqYNYoxBIHR8JM8gGVDs0UFN9EQsv0uGkOu7Y8Ne5xcC6yeBzrlm2zO1FuUQRf6qal6EZqn8l6rVl4tDBhwg9aw2VotgkFO96UWbUEUcVe8sE017Drxzi0gVjVYCL4ZWthdVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706372; c=relaxed/simple;
	bh=pOOevw4SOeWCFRuoy9/RuwntpDWRzXh4XpYogzjOBok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M8rWQk8rFtMdjBUuOdYtKYa5iXj+gJ9BF5Sbzv8WQVv69F1hKg0icsy2b87aB8zLpWlNrHqXqdBleSAkhvR2Py/VOStxVuydTCqxxPJ3mvnDY+9T9kiMRPSPxJnEnX8hiNKo8+qHku2Fuu2f1HThiRg7xX/mwEbjN/YrVNdP+L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=s+kVdP3+; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7C945403E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731706364; bh=gf1INKmijlcCwqsEbqUqjWF1C+dktDwsc67AR5WJTd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=s+kVdP3+fJrVjt9lM7y7DF11yQHNAtToHeaQ7F8oAhFY73OOtvRT+5gkJ/N3JFKOr
	 Oag64UJiR8hMz2svwtq9i8HnOymMipO0EH96c5c+ZdgOWo4iKDnkQdg+cMi3Yor3m/
	 IxNmg8aZD7YYd+8E8yPH0gvug61NlauUlo73dGvHkBBhBKni17ZShKH2xapLk0gxyF
	 Pf/h8x8UTOrLVnVisdOdPeGraP1S+Ou2s270POvXeAAdx0ZJc+CDAdvD2CkZptAJfk
	 C/iI/+ZkMqzwWfGTBGhsZpuShKKMJbT5ergmSDmPryk4d/R1wg5JYMc7g9cWs+2wTZ
	 9Qkv7LoMiK2Qg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7C945403E7;
	Fri, 15 Nov 2024 21:32:44 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>, gregkh@linuxfoundation.org
Cc: Shuah Khan <skhan@linuxfoundation.org>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
 broonie@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Miguel
 Ojeda <ojeda@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Steven Rostedt <rostedt@goodmis.org>, Dan Williams
 <dan.j.williams@intel.com>, Theodore Ts'o <tytso@mit.edu>, Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v4] Documentation/CoC: spell out enforcement for
 unacceptable behaviors
In-Reply-To: <20241114205649.44179-1-skhan@linuxfoundation.org>
References: <20241114205649.44179-1-skhan@linuxfoundation.org>
Date: Fri, 15 Nov 2024 14:32:43 -0700
Message-ID: <87ttc8ji84.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shuah Khan <skhan@linuxfoundation.org> writes:

> The Code of Conduct committee's goal first and foremost is to bring about
> change to ensure our community continues to foster respectful discussions.
>
> In the interest of transparency, the CoC enforcement policy is formalized
> for unacceptable behaviors.
>
> Update the Code of Conduct Interpretation document with the enforcement
> information.
>
> Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Jonathan Corbet <corbet@lwn.net>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Acked-by: Theodore Ts'o <tytso@mit.edu>
> Acked-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>
> Changes since v3:
> - Modifies kernel.org actions as per Konstantin's comments
> - Adds Konstantin's Ack
>
> Changes since v2:
> - Adds details on the process leading up to the proposed
>   measures to seek public apology and bans for serious
>   unacceptable behaviors.
>
> - Hope this addresses your comments, Daniel Vetter,
>   Laurent Pinchart, and Mark Brown.
>
> - Would like to get this into 6.12 if at all possible.
>
> Changes since v1:
> - Updates Acks with Ted's ack.
> - Fixes subsection formatting as per Randy's suggestion.
> - Fixes a spelling error.
>
>  .../code-of-conduct-interpretation.rst        | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)

We seem to have reached a conclusion on this, so I have applied it.

Thanks,

jon


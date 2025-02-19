Return-Path: <linux-kernel+bounces-522150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E37A3C6B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3330E179CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FA22139C4;
	Wed, 19 Feb 2025 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3hIgDLX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BB0192580
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987457; cv=none; b=YN/tIcRAfABxTnq5DIMcOw8oYX0zhjI1jlhU0IM/tDM13by/6PjCZklKWf3vYinyMfioUXKMz5AE3h7c77IVnJ2y/wn3ZSImWplFAC7YGLo99NmS9MpJsGPDiWyK7RA5lZ+FRoxMJdw/IyLpAlkqCsjkNIQusPopXFSj7PAPB8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987457; c=relaxed/simple;
	bh=LhceaD7KQjDq9ozhSrykMWNVsJdLZt+E4/+9DnJdKZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eqpfu7FURdb1XaIhlrWVGqA8qI86XeKuiHuI/7bjci2I2rZKb7pn2Ti1o9ZDrZLnOUvod42pYhTUdLj7GS+rDm/RYCbeBnjehM7A6kwbpFzfA51RpFW8leRcq0oAkWrJ9YBk0xqsDyR001Q4ZLz5NxJJMpz84UoxaYO1IPgAlfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3hIgDLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B070C4CED1;
	Wed, 19 Feb 2025 17:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739987457;
	bh=LhceaD7KQjDq9ozhSrykMWNVsJdLZt+E4/+9DnJdKZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a3hIgDLXwBAhiRa4a+796H9gVMoarq98RfZEycMYyG0tnx5LSS1BxTZelGOFtOKiy
	 P+IISpufYzUOXIqkkZ26a691nr3dMFWhHWeBUHyV7HnvvyWg65ibbwCAma9VZiMi7+
	 8X9qBvQyLABki8H3YWSZvbGd76BL4gt3fMqOMgoxJ6oFMOvrRuM+YkuhU+YBi2RbVI
	 LJ+ROJDwfXaUDvPCXAHvKkeMKD/GU+K9MhVI1S5rHQoaQLnemr07NKJshswzUEs9s4
	 ZpKW4aUqRFN/24IP87O2DWOV7OWUitojVkpYkPkIurcP8/rXP+/yT7sQ4GRUYO1nAN
	 k3NQVoaZ6x24A==
Date: Wed, 19 Feb 2025 09:50:54 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v3 01/10] x86/cfi: Add warn option
Message-ID: <202502190941.CA60135@keescook>
References: <20250219162107.880673196@infradead.org>
 <20250219163514.364049576@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219163514.364049576@infradead.org>

On Wed, Feb 19, 2025 at 05:21:08PM +0100, Peter Zijlstra wrote:
> Rebuilding with CFI_PERMISSIVE toggled is such a pain, esp. since
> clang is so slow.

This seems too complex; report_cfi_failure() already has the fail/warn
logic test. I would have expected cfi_warn to take CONFIG_CFI_PERMISSIVE
as a default instead, like:

+bool cfi_warn __ro_after_init = IS_ENABLED(CONFIG_CFI_PERMISSIVE);

and then just replace report_cfi_failure()'s check of
CONFIG_CFI_PERMISSIVE with cfi_warn:

-        if (IS_ENABLED(CONFIG_CFI_PERMISSIVE)) {
+        if (cfi_warn) {

-Kees

(I do worry about data-only attacks going after page tables and flipping
pages to r/w and changing cfi_warn to 1, but that's probably on the same
order of difficulty as targeting the cfi handler function itself. Hmpf.)

-- 
Kees Cook


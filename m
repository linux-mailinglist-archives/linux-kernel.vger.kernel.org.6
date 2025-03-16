Return-Path: <linux-kernel+bounces-563021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6011A635CA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 14:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA89F3AF6B1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 13:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ED21A83F5;
	Sun, 16 Mar 2025 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC/Exgjh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D31DFF8;
	Sun, 16 Mar 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742131464; cv=none; b=HGTRctO0XJa/az1+xXHR2aA7n4wN8D3GbnnMdStVZDFNqWbKz0hvzcK7AbiYWBy0Keq/5tmDJvv+3ZYx50CoiAW/+KkZBNUD6rH/HzlHqaynwFQZHYie17X1xvcxtitnETXVa7deGbKXBpVS+vdumVr1ZRJ/AE4MmvaQYiqSVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742131464; c=relaxed/simple;
	bh=3GkrF1TybAcnY2XTemxFhmvRgQl9tkQV+cB2pR4rYjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQdJuFw+33xY2wIaWd7GK/kLn8kZ7AA/hjD6i49wd2m9mwhKILFhwsLYFb+OpkUhuFSIq9OqQvYHIETblLFvIr0B1JCJ+n9f100vRylT6dLIFFFnabpof0yz3T3aUTe65YVOP4quXC3BQDZpCsUY61G+Tnd355DzZeKHwDsMiHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aC/Exgjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A28C4CEDD;
	Sun, 16 Mar 2025 13:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742131463;
	bh=3GkrF1TybAcnY2XTemxFhmvRgQl9tkQV+cB2pR4rYjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aC/Exgjh0Pt4R5I2940Q8WL9NoojmjEymT2KAQAW8MnFKLIhE3cQf1CjLyNi+k7e5
	 cxllYdOzyxUpcZcrzcnUTU1BjElOTYUqT2pHhiDn2DF571/GAGpcjp6ZLd9F0UBy2Q
	 kW/RIbWiKUSxlRMyWH72THvQI03cGS8602ypbeQhEn+NRS/sWgQRadpwhLZbpxRSiu
	 LP/0jpvVAMelO+wzZQ5z3NVtqKIchY0JxVE+iKJR2efgsd/D7f+DnbJ/13YH+EXakD
	 wiVDfCmi6rgI2LOpL58B9ONhnbKLJjMMtMICxOb6OW2M5VXnaogPndxb/xupWtV8di
	 8CYotOI+USiTQ==
Date: Sun, 16 Mar 2025 13:24:17 +0000
From: Simon Horman <horms@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: workflows@vger.kernel.org, apw@canonical.com, conor@kernel.org,
	corbet@lwn.net, dwaipayanray1@gmail.com, geert+renesas@glider.be,
	gitster@pobox.com, joe@perches.com, kees@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@leemhuis.info, lukas.bulwahn@gmail.com,
	miguel.ojeda.sandonis@gmail.com, niklas.soderlund@corigine.com,
	torvalds@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH] scripts: Add git-resolve tool for full SHA-1 resolution
Message-ID: <20250316132417.GC4159220@kernel.org>
References: <20250311165336.248120-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311165336.248120-1-sashal@kernel.org>

On Tue, Mar 11, 2025 at 12:53:36PM -0400, Sasha Levin wrote:
> Introduce git-resolve.sh, a tool that resolves short git commit IDs to their
> full SHA-1 hash. This is particularly useful for navigating references in commit
> messages and verifying Fixes tags.
> 
> When faced with ambiguous commit IDs or imprecise references in messages,
> this tool can help by resolving commit hashes based on not just the ID
> itself but also the commit subject, making it more robust than standard
> git rev-parse.
> 
> This is especially valuable for maintainers who need to verify Fixes tags
> or cross-reference commits. Unlike proposals to add dates to Fixes tags
> (which would break existing tooling), this script provides a way to
> disambiguate commits without changing the established tag format.
> 
> The script includes several features:
> - Resolves short commit IDs to full SHA-1 hashes
> - Uses commit subjects to disambiguate between multiple potential matches
> - Supports wildcard patterns in subjects with ellipsis (...)
> - Provides a force mode to attempt resolution by subject when ID lookup fails
> - Includes comprehensive self-tests
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  scripts/git-resolve.sh | 199 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 199 insertions(+)
>  create mode 100755 scripts/git-resolve.sh
> 
> diff --git a/scripts/git-resolve.sh b/scripts/git-resolve.sh

...

> +git_resolve_commit() {
> +	local force=0
> +	if [ "$1" = "--force" ]; then
> +		force=1
> +		shift
> +	fi
> +
> +	# Split input into commit ID and subject
> +	local input="$*"
> +	local commit_id="${input%% *}"
> +	local subject=""
> +
> +	# Extract subject if present (everything after the first space)
> +	if [[ "$input" == *" "* ]]; then
> +		subject="${input#* }"
> +		# Strip the ("...") quotes if present
> +		subject="${subject#*(\"}"
> +		subject="${subject%\")*}"
> +	fi
> +
> +	# Get all possible matching commit IDs
> +	local matches
> +	readarray -t matches < <(git rev-parse --disambiguate="$commit_id" 2>/dev/null)
> +
> +	# Return immediately if we have exactly one match
> +	if [ ${#matches[@]} -eq 1 ]; then
> +		echo "${matches[0]}"
> +		return 0
> +	fi
> +
> +	# If no matches and not in force mode, return failure
> +	if [ ${#matches[@]} -eq 0 ] && [ $force -eq 0 ]; then
> +		return 1
> +	fi
> +
> +	# If we have a subject, try to find a match with that subject
> +	if [ -n "$subject" ]; then
> +		# Convert subject with possible ellipsis to grep pattern
> +		local grep_pattern
> +		grep_pattern=$(convert_to_grep_pattern "$subject")
> +
> +		# In force mode with no ID matches, use git log --grep directly
> +		if [ ${#matches[@]} -eq 0 ] && [ $force -eq 1 ]; then
> +			# Use git log to search, but filter to ensure subject matches exactly
> +			local match

I suppose it doesn't matter in practice, but it seems somewhat inconsistent
to declare match as local here...

> +			match=$(git log --format="%H %s" --grep="$grep_pattern" --perl-regexp -10 | \
> +					while read -r hash subject; do
> +						if echo "$subject" | grep -qP "$grep_pattern"; then
> +							echo "$hash"
> +							break
> +						fi
> +					done)
> +			if [ -n "$match" ]; then
> +				echo "$match"
> +				return 0
> +			fi
> +		else
> +			# Normal subject matching for existing matches

... but not here.

> +			for match in "${matches[@]}"; do
> +				if git log -1 --format="%s" "$match" | grep -qP "$grep_pattern"; then
> +					echo "$match"
> +					return 0
> +				fi
> +			done
> +		fi
> +	fi
> +
> +	# No match found
> +	return 1
> +}

...


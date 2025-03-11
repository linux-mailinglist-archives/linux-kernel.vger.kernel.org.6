Return-Path: <linux-kernel+bounces-556915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E522DA5D097
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED153AA7DE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0DB264633;
	Tue, 11 Mar 2025 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gONZZL7o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAFD25E801;
	Tue, 11 Mar 2025 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741724052; cv=none; b=gf0+aZ1k4mnfr/242QJPNxNdgN3lApXMtFvemdK2zmpPVAHhnxsTsOkukaMilH6HPWsMqZ/bQ7w0UC8wJppp2LOnuOK+TqNtuw6Q0fsEBgKTCkstEe5eOFbiuQ1ZsR+RhUVLL61ec1cDii69BuXyQx+izCsbHyVtivvgBmcxkLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741724052; c=relaxed/simple;
	bh=t2/l5pNQlg9k+xxLJo5hJ0bGriVrBo2344Rc5sPK4R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFnNof7KZZCQnzhBFkVPmO7yVUzww8GztHOV2tfp9tSA3FCYTxKYiOBIn+HnJ+MPpA/YV6+lg5FccnZg40W6ahKiPqlqs5jC9N5+BhCUPNIdpzsPmz35dHZnE1BImUHlXNdVAxl55K3ZHyY9dE1H9kIA+GQUWVTU/CnbDyfKF2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gONZZL7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E05C4CEE9;
	Tue, 11 Mar 2025 20:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741724052;
	bh=t2/l5pNQlg9k+xxLJo5hJ0bGriVrBo2344Rc5sPK4R0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gONZZL7o8O0o8POw4N5RGNZvz3JYRwK6jkxWSIv8W93B7+QsZ8y4DwtcigUOHd/nv
	 vqbGScI2OBiAtRJHRfR8Uc9n4SsgOPvoOwbtwuNWsHXSDKBHni6OIN74v2+W3iy7mb
	 y1qXr6/5qeuiWPqYrviwfF6pWY6znjBNXIdYq8fPB6eXWbok8Xqb7vxlbuzj2Q5RPU
	 uK1ssXsyEDhwTNMuG+uUNgfZcPw/F/vNe+XAnE13r5a+jQ+ZZkOekMNqmmvrUR0QQA
	 nGnvNj1OIviNX2N7FtMDCI+LM76fvzdV/GrNXaucTkecXvC3TW1IvEGHroZkXBCPq7
	 eyqOXJTdFLkeA==
Received: by pali.im (Postfix)
	id 7FE4280E; Tue, 11 Mar 2025 21:13:57 +0100 (CET)
Date: Tue, 11 Mar 2025 21:13:57 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Armin Wolf <W_Armin@gmx.de>
Cc: "linux@weissschuh.net" <linux@weissschuh.net>,
	Kurt Borja <kuurtb@gmail.com>, akpm@linux-foundation.org,
	mcgrof@kernel.org, russ.weight@linux.dev, dakr@kernel.org,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: In-kernel parser for the BMOF format used by WMI-ACPI
Message-ID: <20250311201357.tyldll7j2eogmryw@pali>
References: <a18f2f93-c8ee-47af-9446-97e3714fc275@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a18f2f93-c8ee-47af-9446-97e3714fc275@gmx.de>
User-Agent: NeoMutt/20180716

On Tuesday 11 March 2025 21:06:16 Armin Wolf wrote:
>  - Is there any way to check whether the Doublespace compression algorithm is still encumbered by patents?

Linux kernel 2.2 or 2.4 had full read/write support for doublespace
compression algorithm in mainline kernel and it was connected with fat
driver. IIRC it was dropped for kernel 2.6 because nobody ported that
vfat code to new fs API and hence doublespace in-kernel compression
algorithm was not needed/used anymore. But I do not remember details.

So IMHO it should not be a problem to reintroduce same code into kernel
again if there is a new need for it.

And in my project I reused the doublespace compression code from old
Linux kernel.


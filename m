Return-Path: <linux-kernel+bounces-199978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D1E8FA8B3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA9E281F4E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC9913D602;
	Tue,  4 Jun 2024 03:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1Je751e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DA313D2AC;
	Tue,  4 Jun 2024 03:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717470756; cv=none; b=CeFR52JmqMCrzQNE/rskDvlfvYyNGC5XysnuWf28GLnQRfJnJDIXvOC5H5mJMMOSnFgyMkb3ibX/ApvTeXQcw2iqHGZQ7ImWY0KFhv9frcfSGWhME2T/9EmpsULxbfVoiyk1uJQAeTQ9pJo4ZFYr6ly8GGhqSi7JO9TWYW3Ib7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717470756; c=relaxed/simple;
	bh=aqccSDAvMh0iQaXfPB6SrOeoGhQkFQLqJr2TS388jxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2HcQkC4FGIK40p7Qf0ahJnfNjBBIEE9stSxuqmrel4LzkI64W4qR0J5wp+BQiIPHO323sL8v3E65WMjvM1/sJWYCWwq4u+LXZn2p9DMm7e/t9DPSOfA+awWjMeijpU+9FTd95pbmeMjiLm7es0CKnr/mCHc6haJzTMyV+wnz5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1Je751e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E66FC2BD10;
	Tue,  4 Jun 2024 03:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717470756;
	bh=aqccSDAvMh0iQaXfPB6SrOeoGhQkFQLqJr2TS388jxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1Je751ep2YhUlYYEffup/AJPPcD9+z1v6Tb2TeAWZ9Jqv3XRaG8Poa+RqXg1kOuo
	 sGODvb1+xH8J1IbGJEFSESjqLCSwtqNT0QGll5opsX4MKt60oj3ON5f3YuHcT+qFhA
	 /UTFwBfGb4InJxyFSGErE8tmbupAzgQDd7a9OAtUNb0nHB6RXBQr3BhU4Fm09XZxKT
	 blb009g+UkZWEoVryEHKuKefqdJ88+FPWbqyKpQ/eZw2F3daJl8NZcl3mOufgyI9Ij
	 IFKrpWXyJzJQYoRPyIgrE7i62eX+8jM6xL5NsAjtF3J6CTUpL6cg8koybnVDQv3Jq9
	 AEoJIiiJjnlBg==
Date: Tue, 4 Jun 2024 03:12:32 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Daisuke Nojiri <dnojiri@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Reka Norman <rekanorman@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@google.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Pavan Holla <pholla@chromium.org>,
	Ching-Kang Yen <chingkang@chromium.org>,
	Lukasz Majczak <lma@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_proto: Upgrade
 get_next_event to v3
Message-ID: <Zl6GIDy_QT5iB8OS@google.com>
References: <20240604005354.2294468-1-dnojiri@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604005354.2294468-1-dnojiri@chromium.org>

On Mon, Jun 03, 2024 at 05:53:12PM -0700, Daisuke Nojiri wrote:
> This CL upgrades get_next_event to version 3.

s/This CL upgrades/Upgrade/.

> BUG=b:331761304
> TEST=Type keys on Kyogre.

Please remove the tags as upstream doesn't use them.

>  .../linux/platform_data/cros_ec_commands.h    | 34 +++++++++++++++++++

Please separate the changes of the header into an independent patch.  Says,
the changes in the header is a "sync" from include/ec_commands.h of EC which
is unlikely to be reverted.  However, the rest of changes in the patch could
be reverted if something went wrong.


Return-Path: <linux-kernel+bounces-311116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA11D968510
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB0A1C22395
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9455B166F28;
	Mon,  2 Sep 2024 10:45:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCEA13B2A8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273900; cv=none; b=uW/QvC/rmK+AEwUYLsR/zDL474x8BGiM+d1BC4/8FAybQmF8yyyMK1z7QIhpq9s+ipueLoV4w9weer0ZyP2g6ALYEZj81tppO0dDvOV00PdAE8n9RAinAAGqlXoLWJTdBHjMxBBOwmA7xOR1ttuM+yo//VD/bSoRtfv9KdElBIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273900; c=relaxed/simple;
	bh=J5AVmty/kNkLhkqYmqIkStp49fFb+743PjNX7jVOMbA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qHkAu0OaviMJ54l9CoDZ5IUWxhfUJMJN8YF2+sLIAB5WGax/RL6bUZA3YK5yc8qpk/ZksEJV+XbflUTpKFhQwhPmI+9yB2NsfEB8LlCu9pznmm+JzpzUrWFpzF3bdQwfTSyR1jB4nfmp6dafpaOuLM/vItiheV3sZtR7fgkB4Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl4YK-00060V-Rn; Mon, 02 Sep 2024 12:44:56 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl4YK-004soH-0B; Mon, 02 Sep 2024 12:44:56 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl4YJ-000htx-32;
	Mon, 02 Sep 2024 12:44:55 +0200
Message-ID: <a73a4bfb60b63a1253514289e59b8aa989cbd47a.camel@pengutronix.de>
Subject: Re: [PATCH RFC] reset: Provide new devm_reset helpers for get and
 deassert reset control
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Yuesong Li <liyuesong@vivo.com>
Cc: linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Date: Mon, 02 Sep 2024 12:44:55 +0200
In-Reply-To: <743d4b6b-c854-468f-a0c4-8adbf58cd0ea@vivo.com>
References: <20240830033351.233263-1-liyuesong@vivo.com>
	 <743d4b6b-c854-468f-a0c4-8adbf58cd0ea@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mo, 2024-09-02 at 17:52 +0800, Yuesong Li wrote:
>=20
> On 2024/8/30 11:33, Yuesong Li wrote:
> > When a driver wants to get reset control and deassert it,this
> > helper will handle the return value of these function, also it
> > will register a devres so that when the device been detached, the
> > reset control will be assert.
> >=20
> > Signed-off-by: Yuesong Li <liyuesong@vivo.com>

Could you have a look at the pre-deasserted / auto-reasserting reset
control series [1] and see if that would fit your use case?

[1] https://lore.kernel.org/all/20240621-reset-get-deasserted-v1-0-94ee76fb=
7b7d@pengutronix.de/

regards
Philipp


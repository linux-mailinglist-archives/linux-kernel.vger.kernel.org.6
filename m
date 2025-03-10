Return-Path: <linux-kernel+bounces-555259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB552A5AB42
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA28188C55D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DB121421F;
	Mon, 10 Mar 2025 23:09:23 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D671F872A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648162; cv=none; b=BeQoVcNRn+R1G+m2otBDzIu/bcvtgUzFZ2wRYo4iXhRSlagNyXaQDoGuZJNCXkjLk5FQDygVR003fJ/atXXmMAtb9QPXvQCII7guWrsahuoN19TV5e6monE+VwCsXM1wfg3ID1xIEqra6RiGFkxLTMNhM24VhV8el5Fb1qOT++o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648162; c=relaxed/simple;
	bh=Aq6JMMQQE8ANCi+wTX/cmkYGXzi0hJhicRf+2384CBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lik2JY4q0kYOk9eZ2J2ZvUJT6YpBQTFbsdPGAHi/lleWw/yKYAirzuguLSvKtkLAeMsJqSsYyb10mVbzjbBp5zzLBhrCRBLRRj6pKr5JKEHxLrPiXyXT43J7tdhkEU/Zyacw+o6eQlvMo4mZerP2x7U657ikB39FaEy5IlB7iiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.113])
	by sina.com (10.185.250.22) with ESMTP
	id 67CF711700007D34; Mon, 11 Mar 2025 07:09:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3924107602641
X-SMAIL-UIID: FA620097D2A14F02AA979352F2ED5371-20250311-070913-1
From: Hillf Danton <hdanton@sina.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Qun-Wei Lin <qun-wei.lin@mediatek.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] kcompressd: Add Kcompressd for accelerated zram compression
Date: Tue, 11 Mar 2025 07:08:56 +0800
Message-ID: <20250310230902.3282-1-hdanton@sina.com>
In-Reply-To: <CAGsJ_4w8cFgdPmHH5KLeKoEEVN1LT4-z0sX_2vtV5sc7yOQb8g@mail.gmail.com>
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com> <20250307120141.1566673-3-qun-wei.lin@mediatek.com> <CAGsJ_4xtp9iGPQinu5DOi3R2B47X9o=wS94GdhdY-0JUATf5hw@mail.gmail.com> <CAKEwX=OP9PJ9YeUvy3ZMQPByH7ELHLDfeLuuYKvPy3aCQCAJwQ@mail.gmail.com> <20250309010541.3152-1-hdanton@sina.com> <CAKEwX=Mwh9SKWfmaS9q4fym7L-v5m6GmvJrQF8eFizJJd904rA@mail.gmail.com> <CAGsJ_4wFfqFZQw-TOM83gUEV_rN6uio1sujXdjCRKTOipPM2SQ@mail.gmail.com> <20250310103427.3216-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 11 Mar 2025 01:44:27 +0800 Barry Song <21cnbao@gmail.com>
> On Mon, Mar 10, 2025 at 6:34 PM Hillf Danton <hdanton@sina.com> wrote:
> > On Mon, 10 Mar 2025 09:44:24 +1300 Barry Song <21cnbao@gmail.com>
> > > I also feel extremely uncomfortable. In Eastern culture, this is an extremely
> > > vulgar word, more offensive than any others.
> > >
> > If culture is not abused, feel free to show us how it is defined to be
> > more offensive than any others in Eastern culture.
> >
> Having no manners is not your fault. The ignorant fear nothing.
>
Oh lad, just tell us anything true. It is not difficult.


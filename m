Return-Path: <linux-kernel+bounces-275273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1667094829A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449DC1C21507
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E74166F3B;
	Mon,  5 Aug 2024 19:50:16 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275DA14A85
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887415; cv=none; b=HNJq1t40ML0mL7LcBtjD6bRn4p1jlHNw4GLGkVArIVq+YJCHQCArmQCTQtL/aQAXm2n8rUnlKKRRCFXQGi9UzEKLNThBYAGram9z2zliYwBf/qTzChhYqbD1K4c1dQfUak18lBtEo3rU0E6A9CWIQiR3VjbkwCwSq5CQt47/R9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887415; c=relaxed/simple;
	bh=2Oy/nGII+pfiyow3aorPctXMihAHTK/+aMw5FHHbDXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sH1pnUI/CdL4kQuwDjnYvNx2GGrLPh+7FIjxE0qf3paRo+rJPB+IpLGBc77KCzY5RPV+eVEZFovKIHbIlBs3m9LjH+Q3r/f8RZ6qvw1IwJVPVREM3zKOgl9yeV/niQ7pQIxy7BG9AVlVX2GbnXtt4yS4pGqkd+UwI8+u10HvMl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1e1f6a924so709392085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887413; x=1723492213;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Oy/nGII+pfiyow3aorPctXMihAHTK/+aMw5FHHbDXQ=;
        b=rPTNZ1c6FmAlx609vGE6ZPW5k8/jwZ3z0sQhMOIffo44A7UR6q3TsYosfUTfZ3rggN
         hYlitRrxun+pe3Q9ar3QFQ8Pjv7wzDupVBM/agSOfCEjV3YUYLxOr8nuWZA1p+pVQBK4
         rkzDwY9uDAVq9jmTBQLVQdt5HGIR7eWg/xGAjmpoxRJ3DhFTJMPCwTnKudpU9p1RUqPe
         FZZQRlpky546DNcdAsWD6i9Mbn2bhtkAAvevssePaI4imDAw/zTMjPnnjG0gns0qa9/4
         c0iMQ/xCVmNkU6FTJkVsQV9Zq/ysboD78Gn3+xio9+rY/JC9Opb/zpg0cMjO7H2Ri3N4
         rhog==
X-Forwarded-Encrypted: i=1; AJvYcCVtOBvNHJjR+RYk2S1pauxxJX9NNRZXvXDewIpQgxdnMPdNJVvo5vL+NfWzoYhHwjpWUIxHFzNjIeNDpWYSBMK9mn+SIWXPvQhCPp/M
X-Gm-Message-State: AOJu0YzwybltQ6MpZCR0y3M7z9SeLap4Lr3vdjNlS31bqwTZPM+chYJA
	/RDezti0ly6kr5e9ETL8VpgGMYUDc3X+dDQjw0oZlbYBRN4o8xXS
X-Google-Smtp-Source: AGHT+IE++UAfjshCPX9o58ZrprSEuiTQD25QgpzdGbZ3c8FxvN2GYjPRMfnhDgrADMT+o/ycLZCEBQ==
X-Received: by 2002:a05:620a:4485:b0:79d:6d4a:a964 with SMTP id af79cd13be357-7a34eeb8396mr1500807285a.2.1722887412983;
        Mon, 05 Aug 2024 12:50:12 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a6a9b11sm31735591cf.12.2024.08.05.12.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 12:50:12 -0700 (PDT)
Date: Mon, 5 Aug 2024 14:50:09 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com
Subject: Re: [PATCH 5/6] sched_ext: Improve comment on idle_sched_class
 exception in scx_task_iter_next_locked()
Message-ID: <20240805195009.GG42857@maniforge>
References: <20240804024047.100355-1-tj@kernel.org>
 <20240804024047.100355-6-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Szd+9FawudAbBY57"
Content-Disposition: inline
In-Reply-To: <20240804024047.100355-6-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--Szd+9FawudAbBY57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 03, 2024 at 04:40:12PM -1000, Tejun Heo wrote:
> scx_task_iter_next_locked() skips tasks whose sched_class is
> idle_sched_class. While it has a short comment explaining why it's testing
> the sched_class directly isntead of using is_idle_task(), the comment
> doesn't sufficiently explain what's going on and why. Improve the comment.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>

Acked-by: David Vernet <void@manifault.com>

--Szd+9FawudAbBY57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZrEs8QAKCRBZ5LhpZcTz
ZBBRAP4hutg4u8WYqnvbdGXOatQA3x2SINmaYyCGaYVKVvTo1QEAuxJYAcEBXz7T
H7ZarcU7NSZsZpLHEVe7b1TgRdwWjQg=
=BooE
-----END PGP SIGNATURE-----

--Szd+9FawudAbBY57--


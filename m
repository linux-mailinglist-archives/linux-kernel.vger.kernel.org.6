Return-Path: <linux-kernel+bounces-449172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9D29F4AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09574188DA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6201F37D5;
	Tue, 17 Dec 2024 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tsqwhpa/"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C69F1CEEBB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438480; cv=none; b=dj+lfaMgJhRm5fvNlNJrbRjppVLizREtTrALAmzH1vTCiiIBxoo0tsJs8LugyM/x58FAJiG8otMvEUt+e3EisYc3Sx9tsJF5SqNfjpyhFloCsCUhw2Usayb3CnBvRD4ymaEqoffnp3hQGs3+YbxpEXDozAbctGbtRT8X3PJbyfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438480; c=relaxed/simple;
	bh=Dmr+zkG6rFj7xhl58ZvOs1fQmtdJiMol3R2JlnjN8rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fi3zjtF0G8DBx3PKOSIi/DB6FDqZvKTjHd48Un8xnWTz9yV7qXVzxAYHrh6xTI2c1zHrIg+gA/Fg+kmhhnO2bk44KzUF5in0MQ/ZR0qFkYf0pA1BETZtuUVcuqu1ACbpkcQ2NQgpwaMj7PuuYaWTkdzbHXON8a4ueTLaG6ITSAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tsqwhpa/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43622267b2eso55516845e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734438477; x=1735043277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0LZxufIyLTNTAhqLSUtBRCFT9U3DEE8+8dGiQI78bU=;
        b=Tsqwhpa/fVz1Q+9/Czx+kDuVvryX0xpoVLS/D/QrAZ5+guWUlGND8ol9ThqjxP77Xp
         SNmI5NLjCKpFFxlIutqruREEbNTSD0vj7IIOQ63RaVDy3Aj7ATnQ4giS8VmmQrHd3ulM
         efBmwIKgTtJEG/1qhMgjp6SPsgV/ktKL55Us+tRLggT/iddgCRHmhMofKOL+TVOdiCKa
         PhSbrVmP9W/nvfZucCSAoulJQvVTjwu+FYRoKIcry1VQgeL1rwaHk8cP2yRkXR5iKFRv
         d1KMDG85c9mU7iUV+uOXDkFBnOh1Ij805cZcSQT7WQiV7Azdgp2d7tkpjcphH4LzhVbY
         ottQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734438477; x=1735043277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0LZxufIyLTNTAhqLSUtBRCFT9U3DEE8+8dGiQI78bU=;
        b=q4n1hpI+KqUm7x79TBL7eUWR69J5qVmbzAWL3n96jFdlzFo+iKKcTsVYXa3rJUAji6
         Qhs3PN1E1WnqafkEZeVsewDVFf46hyrCVf70b2OXao1kvoV725F9sffttdK6RrVXOqE2
         7A1arHbtwlFk/iJxmHT6wPb+jFJiZ8k5xZoKhhSJxsrMXKRB5wLe28He3dXyZPaeRIsU
         JaDWujkfq+GTzYcgXbbkMT5ihGRJWWSvDYwOjYpD3+Jn2+dFI6ea5qYqD6Lh4UZbadYG
         q3d8S5OEKmQczMXe5GdHz27M7ntNGpR1nfMyWcmdTWp9okilguZi1Vl7rXW6MkyIlyZz
         lJ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWx6m8fsHWf0K9YpodgJ26gApjChknQeLpWxKQAqiA8WFAbCbS6UjuIXr4T32eZ9pdlekwuMUm5TUpT2cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvM88inQj3Mw1enF2NbU25tsQsma+edbIayKnQ0HAzbNa8AZfy
	rsRlFjs/M0Z1qg6jSgtojsCyVFEhZ7jU+M3bFm3xFmFauOUWi2KGx4f0zZfJreU=
X-Gm-Gg: ASbGncsjIKnpwYmBU4ZSPWt3vBxzgIOzJhQey1HIG4Jk43Sz8mk2o6wOSMrKIbs/0EK
	IFZR5qNu+Z3nPYT111M+Fon5Vmp3Cq/KMB4asYoMlk4ksh4WpWa0PUn8thZCRR6ovNScbFVrECs
	RHZMH3sq/OmABHIRaZQ+IPtORDWZE3pqkawyVzIoGHoq7uYrvoQNWjn+SrKhMkaiYeJL4jKx+GS
	wuEAhtGZIAwJuot378U0AMVaoCakiocWTHrB6Tc/ypxtFAlRgSj3++9SHs=
X-Google-Smtp-Source: AGHT+IHBtk/ewjC+33KbY4kiTsyCa8gijFZMuXZ9Ou3NqePKUlzgP3VG7Yh6lLlkFNIG7kqZNOpvkQ==
X-Received: by 2002:a05:600c:4e11:b0:434:f804:a9b0 with SMTP id 5b1f17b1804b1-4362aaa49b1mr148537805e9.29.1734438476734;
        Tue, 17 Dec 2024 04:27:56 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm19216035e9.0.2024.12.17.04.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:27:56 -0800 (PST)
Date: Tue, 17 Dec 2024 13:27:54 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, chenridong@huawei.com, 
	wangweiyang2@huawei.com
Subject: Re: [next -v1 2/5] memcg: call the free function when allocation of
 pn fails
Message-ID: <ohkphvmcs6c6lpz6ogglkg3p3maqgx6mrv53gezsqdf2mk7u3h@klcxc76nloq7>
References: <20241206013512.2883617-1-chenridong@huaweicloud.com>
 <20241206013512.2883617-3-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ki3l36ikdb6o5jh"
Content-Disposition: inline
In-Reply-To: <20241206013512.2883617-3-chenridong@huaweicloud.com>


--3ki3l36ikdb6o5jh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 01:35:09AM GMT, Chen Ridong <chenridong@huaweicloud=
=2Ecom> wrote:
> From: Chen Ridong <chenridong@huawei.com>
>=20
> The 'free_mem_cgroup_per_node_info' function is used to free
> the 'mem_cgroup_per_node' struct. Using 'pn' as the input for the
> free_mem_cgroup_per_node_info function will be much clearer.
> Call 'free_mem_cgroup_per_node_info' when 'alloc_mem_cgroup_per_node_info'
> fails, to free 'pn' as a whole, which makes the code more cohesive.
>=20
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  mm/memcontrol.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)

(Little of a judgment call but also)
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--3ki3l36ikdb6o5jh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ2FuSAAKCRAt3Wney77B
SfQ+AP9X381Jf33s+FoGPIzwzpwnzlojkNv+6yBvGADf83dixAEAuDtx7wBMm/XQ
5z+3XnDlJossa9WZtwtwcsYoas3gtQc=
=d3q2
-----END PGP SIGNATURE-----

--3ki3l36ikdb6o5jh--


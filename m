Return-Path: <linux-kernel+bounces-529709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F5CA42A11
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C1BA7A990E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4A2264F94;
	Mon, 24 Feb 2025 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q037XNes"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B4E264FBA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418687; cv=none; b=GHIs9UM9MmaAhGlFPs4mg2p31OaCfmJ3o0gN91rtDYt4XhyTAZzc1qfsCLj1OZVlqe18aRtrJAFgQxrOefpTMT005vblW1aE5at+/FQjg9Ri8l2lzgTbp01aXJic/EP0CY8usSTksqBrB+KEF2jh7HCMsB2a+YZGUuXnDOe40ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418687; c=relaxed/simple;
	bh=hn62BCty7GQyDPb08bGnE6rYl/WWjbeHu5GYY+luZiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Koijtjb6AUu0J7pjHl87hXPYfyCSPsUQEF7vjuBJ7rLGtkbVqFjYyjwBSlOe9YBIslqTaQNTzIVM7xSA8kWQ0cgaEl3EOv5IdwN1HHLs/63xA5IT5Kyi9/7eNXgZgFGzGiP6L6IxYU2kYr3nmUMqatyGLaf16ipLUjnUcLLqU+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q037XNes; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-471fbfe8b89so6211cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740418684; x=1741023484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/O0vbrO92duvYr6F7i3L1H8Ny2GEtGfhV4xH02ux58=;
        b=q037XNes3HEGRyAYjkB6XXqUH6lsXxFu6wLOPbutnaov4qOIiHtmH3sVQ/oqVcGaei
         YeMCSJcMdk+PnY42e5uuELXoh/Edcrw5ctvu7FqmyGpdTH65Ap949Cxjmn0SlyDTpprY
         JUfiSiPA3gNLdLQM/ruTvi+mboiRuSAkRO4P3W2O7Yl5sNOE3aS55V7VnRein96x2YR6
         hMZ5hUojUO50Qhuqv3hQzBBnOnv2zX6ZLWjzdKhn8g9R+6CVVNiRr8C4XvlSp/EbXrZa
         9P5zYjzsNPOXXbWhCTvRoqfx0xEINKz73dsAYeItGZlbLFmtszEF/cF9/Q6ZzXMcQfwA
         tnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740418684; x=1741023484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/O0vbrO92duvYr6F7i3L1H8Ny2GEtGfhV4xH02ux58=;
        b=NBCWODMIBvMstkpw6+Fzlxvxuf/eI6DjXYnvR3rDmSQV54QzDSEIod1G7oUm6dk4zh
         Ws+1j89edIdmak2YBijmZNCPHY0hihBeWz473m2XUABT++XZuZRSomqDzv3CA5DNr1E+
         Kb7/QzB1Pfoq6LMh6aT/rHF6Ugc0q5rgKGqMp07BSRAtGRquV25aREVqD/7EDXHNskZV
         j9TxrhT9AVCS71RvHBQ8y38MFYCCq5ClK8g/9nfPjutIIpAT+5CMDlGoA4Bz2WWcus/o
         iyOxhlBFYkpM0IMPWk3ANpguCUnJhPBhNWlheEUBx6XgX/cC3gMubRhcjjENzu1ugkIf
         qVUw==
X-Forwarded-Encrypted: i=1; AJvYcCXJJYWaONWmTbYXm2ulBmzLqLkHhPU0iC45Sx3A6sctG5XKLezGY2aUJa4+HmWgnArWBYJwFBwJDKss90E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDK13rRqQGXxH+SnLlkU4DKmceqsUohG+0XpXvxJ3lU/jblw/2
	Fqj4s8oUzj9shxU3MlBoNmyYRtIFj8jgLA4laBSD6hONaTr8RERI09XXLH8hkyM5O/juxGWy0iN
	Is2DIMuCr3oh+//ut4lvBcMLgiWqivneMs5+c
X-Gm-Gg: ASbGncsI4RMeQXN/dcWFahbajdt1ySVneussULK5t9bbQeyhWihhGFfN+yI9sKN+kEa
	DGvGQP5FHVTMUe+NqwoQ6FdX5Rr/dewpdyGbJVlOynXSdFwNkZ6ptWtKY3OvgDeqs9Zwrbsi20Q
	lRUn6i
X-Google-Smtp-Source: AGHT+IH3iTdeqfq4jur2rjKozlveokHS0xXgOXYk6eu+6erAuMQ+D8KPGLkRByg6hsOrf2mAtKqTssMrL/1wfcTtqtE=
X-Received: by 2002:a05:622a:13ca:b0:466:861a:f633 with SMTP id
 d75a77b69052e-47376e5d9bdmr232651cf.5.1740418684082; Mon, 24 Feb 2025
 09:38:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-hugepage-parameter-v1-0-fa49a77c87c8@cyberus-technology.de>
 <20250221-hugepage-parameter-v1-1-fa49a77c87c8@cyberus-technology.de>
In-Reply-To: <20250221-hugepage-parameter-v1-1-fa49a77c87c8@cyberus-technology.de>
From: Frank van der Linden <fvdl@google.com>
Date: Mon, 24 Feb 2025 09:37:52 -0800
X-Gm-Features: AQ5f1Jo9ImB_9IaphJKYV-I3Hv0ey8xUJZJhhhQp9XGv1YVwKjURQJn1eQch93I
Message-ID: <CAPTztWaRDD9v+-yk_DJAb9FzZDyQF93B_BawxcmSSUitRp1a5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: hugetlb: add hugetlb_alloc_threads cmdline option
To: thomas.prescher@cyberus-technology.de
Cc: Jonathan Corbet <corbet@lwn.net>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 5:49=E2=80=AFAM Thomas Prescher via B4 Relay
<devnull+thomas.prescher.cyberus-technology.de@kernel.org> wrote:
>
> From: Thomas Prescher <thomas.prescher@cyberus-technology.de>
>
> Add a command line option that enables control of how many
> threads per NUMA node should be used to allocate huge pages.
>
> Allocating huge pages can take a very long time on servers
> with terabytes of memory even when they are allocated at
> boot time where the allocation happens in parallel.
>
> The kernel currently uses a hard coded value of 2 threads per
> NUMA node for these allocations.
>
> This patch allows to override this value.
>
> Signed-off-by: Thomas Prescher <thomas.prescher@cyberus-technology.de>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  7 ++++
>  Documentation/admin-guide/mm/hugetlbpage.rst    |  9 ++++-
>  mm/hugetlb.c                                    | 50 +++++++++++++++++--=
------
>  3 files changed, 49 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index fb8752b42ec8582b8750d7e014c4d76166fa2fc1..812064542fdb0a5c0ff7587aa=
aba8da81dc234a9 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1882,6 +1882,13 @@
>                         Documentation/admin-guide/mm/hugetlbpage.rst.
>                         Format: size[KMG]
>
> +       hugepage_alloc_threads=3D
> +                       [HW] The number of threads per NUMA node that sho=
uld
> +                       be used to allocate hugepages during boot.
> +                       This option can be used to improve system bootup =
time
> +                       when allocating a large amount of huge pages.
> +                       The default value is 2 threads per NUMA node.
> +
>         hugetlb_cma=3D    [HW,CMA,EARLY] The size of a CMA area used for =
allocation
>                         of gigantic hugepages. Or using node format, the =
size
>                         of a CMA area per node can be specified.
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation=
/admin-guide/mm/hugetlbpage.rst
> index f34a0d798d5b533f30add99a34f66ba4e1c496a3..c88461be0f66887d532ac4ef2=
0e3a61dfd396be7 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -145,7 +145,14 @@ hugepages
>
>         It will allocate 1 2M hugepage on node0 and 2 2M hugepages on nod=
e1.
>         If the node number is invalid,  the parameter will be ignored.
> -
> +hugepage_alloc_threads
> +       Specify the number of threads per NUMA node that should be used t=
o
> +       allocate hugepages during boot. This parameter can be used to imp=
rove
> +       system bootup time when allocating a large amount of huge pages.
> +       The default value is 2 threads per NUMA node. Example to use 8 th=
reads
> +       per NUMA node::
> +
> +               hugepage_alloc_threads=3D8
>  default_hugepagesz
>         Specify the default huge page size.  This parameter can
>         only be specified once on the command line.  default_hugepagesz c=
an
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 163190e89ea16450026496c020b544877db147d1..b7d24c41e0f9d22f5b86c253e=
29a2eca28460026 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -68,6 +68,7 @@ static unsigned long __initdata default_hstate_max_huge=
_pages;
>  static bool __initdata parsed_valid_hugepagesz =3D true;
>  static bool __initdata parsed_default_hugepagesz;
>  static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata;
> +static unsigned long allocation_threads_per_node __initdata =3D 2;
>
>  /*
>   * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_=
pages,
> @@ -3432,26 +3433,23 @@ static unsigned long __init hugetlb_pages_alloc_b=
oot(struct hstate *h)
>         job.size        =3D h->max_huge_pages;
>
>         /*
> -        * job.max_threads is twice the num_node_state(N_MEMORY),
> +        * job.max_threads is twice the num_node_state(N_MEMORY) by defau=
lt.
>          *
> -        * Tests below indicate that a multiplier of 2 significantly impr=
oves
> -        * performance, and although larger values also provide improveme=
nts,
> -        * the gains are marginal.
> +        * On large servers with terabytes of memory, huge page allocatio=
n
> +        * can consume a considerably amount of time.
>          *
> -        * Therefore, choosing 2 as the multiplier strikes a good balance=
 between
> -        * enhancing parallel processing capabilities and maintaining eff=
icient
> -        * resource management.
> +        * Tests below show how long it takes to allocate 1 TiB of memory=
 with 2MiB huge pages.
> +        * 2MiB huge pages. Using more threads can significantly improve =
allocation time.
>          *
> -        * +------------+-------+-------+-------+-------+-------+
> -        * | multiplier |   1   |   2   |   3   |   4   |   5   |
> -        * +------------+-------+-------+-------+-------+-------+
> -        * | 256G 2node | 358ms | 215ms | 157ms | 134ms | 126ms |
> -        * | 2T   4node | 979ms | 679ms | 543ms | 489ms | 481ms |
> -        * | 50G  2node | 71ms  | 44ms  | 37ms  | 30ms  | 31ms  |
> -        * +------------+-------+-------+-------+-------+-------+
> +        * +--------------------+-------+-------+-------+-------+-------+
> +        * | threads per node   |   2   |   4   |   8   |   16  |    32 |
> +        * +--------------------+-------+-------+-------+-------+-------+
> +        * | skylake 4node      |   44s |   22s |   16s |   19s |   20s |
> +        * | cascade lake 4node |   39s |   20s |   11s |   10s |    9s |
> +        * +--------------------+-------+-------+-------+-------+-------+
>          */
> -       job.max_threads =3D num_node_state(N_MEMORY) * 2;
> -       job.min_chunk   =3D h->max_huge_pages / num_node_state(N_MEMORY) =
/ 2;
> +       job.max_threads =3D num_node_state(N_MEMORY) * allocation_threads=
_per_node;
> +       job.min_chunk   =3D h->max_huge_pages / num_node_state(N_MEMORY) =
/ allocation_threads_per_node;
>         padata_do_multithreaded(&job);
>
>         return h->nr_huge_pages;
> @@ -4764,6 +4762,26 @@ static int __init default_hugepagesz_setup(char *s=
)
>  }
>  __setup("default_hugepagesz=3D", default_hugepagesz_setup);
>
> +/* hugepage_alloc_threads command line parsing
> + * When set, use this specific number of threads per NUMA node for the b=
oot
> + * allocation of hugepages.
> + */
> +static int __init hugepage_alloc_threads_setup(char *s)
> +{
> +       unsigned long threads_per_node;
> +
> +       if (kstrtoul(s, 0, &threads_per_node) !=3D 0)
> +               return 1;
> +
> +       if (threads_per_node =3D=3D 0)
> +               return 1;
> +
> +       allocation_threads_per_node =3D threads_per_node;
> +
> +       return 1;
> +}
> +__setup("hugepage_alloc_threads=3D", hugepage_alloc_threads_setup);
> +
>  static unsigned int allowed_mems_nr(struct hstate *h)
>  {
>         int node;
>
> --
> 2.48.1
>
>
>

Maybe mention that this does not apply to 'gigantic' hugepages (e.g.
hugetlb pages of an order > MAX_PAGE_ORDER). Those are allocated
earlier in boot by memblock, in a single-threaded environment.

Not your fault that this distinction between these types of hugetlb
pages isn't clear in the Docs, of course. Only hugetlb_cma mentions
that it is for gigantic pages. But it's probably best to mention that
the threads parameter is for non-gigantic hugetlb pages only.

- Frank


Return-Path: <linux-kernel+bounces-281108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDA294D32F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76211F234D5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7F1199EB0;
	Fri,  9 Aug 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNmme8W9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12759198A1B;
	Fri,  9 Aug 2024 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216451; cv=none; b=cIj9P/UV23yPN30b+DHsdMfnKLZkaqNr3mWeU4dSIOerfNMKms79zvlnDaPA8ZQ9tYPLMA3WGNjYN4VLesS7sgKFncTSBxl7TB1V8WLuW4cCn1DR9GQDzN+5Ph617wxByJJ9rx82vX9v1ceuw7i36onQjWewk5yb1Limsi1CNok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216451; c=relaxed/simple;
	bh=3x1I3t23wv26CQk4jS0uLOBKS6hDL4aBZAdgs4f0xhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bm/xkXb55CclifhFNgDV/P2rC9Pd/DgNEpkjJR1wGAQxk0CW6yBfBWPUhHF9R/SjYJugfsog+Iy/e+5N5XD3QPg0dOwfKWR5VtkzZi1Xsjx1HoZ+w5nzLIUJ6oKSJW+ic3WEi9SPniu7MZmgeCO5GHiJsOOAfMqPDrKyJdhA9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNmme8W9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94080C4AF0B;
	Fri,  9 Aug 2024 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723216450;
	bh=3x1I3t23wv26CQk4jS0uLOBKS6hDL4aBZAdgs4f0xhU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jNmme8W9NB2+ZamfqnIfE9ryfUdk4JqZIuOUSUE4S4CCeEKaYicGo8rgCPRNmeaMP
	 ZGSPGUUn3fLFeZ+HIMe3H4uo70EIGhNqm+BsXHjtmOWV3anXWeWRS1pg7nb2NoO1d8
	 vruhBgCEh+5DrhsfIUHOr2o0uIjMXFXnhEP9wyiGaVDpth4zQ8fSnP2E2CI8sGuBBD
	 /TZNadFJcXZnVY0Kvb1xvCPfdt15ENINs9ZIcRf8W7ZZv0BNu1Y/UXqZBMnOygVryN
	 oeq/zNr3h3VdrleWs2tMTOPcqjiKSkaYLVagUBBTvt7n4BKNsCyDSZGBSQvcm7WaeH
	 WgGKtzEFGXt9w==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f149845fbaso23686091fa.3;
        Fri, 09 Aug 2024 08:14:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKzZDJqGs0fI3A4oJs0uuodsM9sE6MFFzui86swFSzlkdvvdGl/aIiYazjgmWNHpFWassepjrWbH09C+cAa23mYpipsPrgB4Np+t7dm+EcACJ9wyZS22RLSkYcw1QXWmO7dVwfyp9LQQ==
X-Gm-Message-State: AOJu0YzJpVS09ikZ3qiD2C2YVAfPF2TjFG69K+zWVr/kTlxjL3CjhIKG
	ALJ2vKHspoaKvwGP9NmdUqGqvjp4l3xiHkYH/VUOfI5DJcZ00FeFbt20fgzvjgtSHvZLyL+znMl
	7JAWTsaTgNfHYbLxUaj3wkHgglQ==
X-Google-Smtp-Source: AGHT+IG+n/t2ITHrMGpOypuDOMLkf0Ms8xRhO88x2Ilm17PKc6/jHWWGSBIWjCKYSlZxolzdomYTClaXJ0JEUAmc8KM=
X-Received: by 2002:a2e:b8cb:0:b0:2ef:2472:41c7 with SMTP id
 38308e7fff4ca-2f1a6d01eaemr17231031fa.7.1723216448824; Fri, 09 Aug 2024
 08:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809090158.3267481-2-stefan.wiehler@nokia.com>
In-Reply-To: <20240809090158.3267481-2-stefan.wiehler@nokia.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 9 Aug 2024 09:13:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ-qx=FffPZgx3tdsUu1_mA=E1+xZs0dY+GeoEuvUEm_Q@mail.gmail.com>
Message-ID: <CAL_JsqJ-qx=FffPZgx3tdsUu1_mA=E1+xZs0dY+GeoEuvUEm_Q@mail.gmail.com>
Subject: Re: [PATCH v3] of/irq: Prevent device address out-of-bounds read in
 interrupt map walk
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 3:03=E2=80=AFAM Stefan Wiehler <stefan.wiehler@nokia=
.com> wrote:
>
> When of_irq_parse_raw() is invoked with a device address smaller than
> the interrupt parent node (from #address-cells property), KASAN detects
> the following out-of-bounds read when populating the initial match table
> (dyndbg=3D"func of_irq_parse_* +p"):
>
>   OF: of_irq_parse_one: dev=3D/soc@0/picasso/watchdog, index=3D0
>   OF:  parent=3D/soc@0/pci@878000000000/gpio0@17,0, intsize=3D2
>   OF:  intspec=3D4
>   OF: of_irq_parse_raw: ipar=3D/soc@0/pci@878000000000/gpio0@17,0, size=
=3D2
>   OF:  -> addrsize=3D3
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: slab-out-of-bounds in of_irq_parse_raw+0x2b8/0x8d0
>   Read of size 4 at addr ffffff81beca5608 by task bash/764
>
>   CPU: 1 PID: 764 Comm: bash Tainted: G           O       6.1.67-484c6135=
61-nokia_sm_arm64 #1
>   Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2023.01-12=
.24.03-dirty 01/01/2023
>   Call trace:
>    dump_backtrace+0xdc/0x130
>    show_stack+0x1c/0x30
>    dump_stack_lvl+0x6c/0x84
>    print_report+0x150/0x448
>    kasan_report+0x98/0x140
>    __asan_load4+0x78/0xa0
>    of_irq_parse_raw+0x2b8/0x8d0
>    of_irq_parse_one+0x24c/0x270
>    parse_interrupts+0xc0/0x120
>    of_fwnode_add_links+0x100/0x2d0
>    fw_devlink_parse_fwtree+0x64/0xc0
>    device_add+0xb38/0xc30
>    of_device_add+0x64/0x90
>    of_platform_device_create_pdata+0xd0/0x170
>    of_platform_bus_create+0x244/0x600
>    of_platform_notify+0x1b0/0x254
>    blocking_notifier_call_chain+0x9c/0xd0
>    __of_changeset_entry_notify+0x1b8/0x230
>    __of_changeset_apply_notify+0x54/0xe4
>    of_overlay_fdt_apply+0xc04/0xd94
>    ...
>
>   The buggy address belongs to the object at ffffff81beca5600
>    which belongs to the cache kmalloc-128 of size 128
>   The buggy address is located 8 bytes inside of
>    128-byte region [ffffff81beca5600, ffffff81beca5680)
>
>   The buggy address belongs to the physical page:
>   page:00000000230d3d03 refcount:1 mapcount:0 mapping:0000000000000000 in=
dex:0x0 pfn:0x1beca4
>   head:00000000230d3d03 order:1 compound_mapcount:0 compound_pincount:0
>   flags: 0x8000000000010200(slab|head|zone=3D2)
>   raw: 8000000000010200 0000000000000000 dead000000000122 ffffff810000c30=
0
>   raw: 0000000000000000 0000000000200020 00000001ffffffff 000000000000000=
0
>   page dumped because: kasan: bad access detected
>
>   Memory state around the buggy address:
>    ffffff81beca5500: 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>    ffffff81beca5580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   >ffffff81beca5600: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                         ^
>    ffffff81beca5680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>    ffffff81beca5700: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   OF:  -> got it !
>
> Prevent the out-of-bounds read by copying the device address into a
> buffer of sufficient size.
>
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
>  drivers/of/irq.c | 51 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index c94203ce65bb3..34fe0593036d8 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -151,6 +151,26 @@ const __be32 *of_irq_parse_imap_parent(const __be32 =
*imap, int len, struct of_ph
>         return imap;
>  }
>
> +static u32 of_get_address_cells(struct device_node *node)
> +{

See of_bus_n_addr_cells(). It does the same thing. However, I don't
think you need this. See below.

> +       struct device_node *tnode, *old =3D NULL;
> +       const __be32 *tmp;
> +
> +       /* Look for this #address-cells. We have to implement the old lin=
ux
> +        * trick of looking for the parent here as some device-trees rely=
 on it
> +        */
> +       old =3D of_node_get(node);
> +       do {
> +               tmp =3D of_get_property(old, "#address-cells", NULL);
> +               tnode =3D of_get_parent(old);
> +               of_node_put(old);
> +               old =3D tnode;
> +       } while (old && tmp =3D=3D NULL);
> +       of_node_put(old);
> +       old =3D NULL;
> +       return (tmp =3D=3D NULL) ? 2 : be32_to_cpu(*tmp);
> +}
> +
>  /**
>   * of_irq_parse_raw - Low level interrupt tree parsing
>   * @addr:      address specifier (start of "reg" property of the device)=
 in be32 format
> @@ -167,10 +187,10 @@ const __be32 *of_irq_parse_imap_parent(const __be32=
 *imap, int len, struct of_ph
>   */
>  int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq=
)
>  {
> -       struct device_node *ipar, *tnode, *old =3D NULL;
> +       struct device_node *ipar, *tnode;
>         __be32 initial_match_array[MAX_PHANDLE_ARGS];
>         const __be32 *match_array =3D initial_match_array;
> -       const __be32 *tmp, dummy_imask[] =3D { [0 ... MAX_PHANDLE_ARGS] =
=3D cpu_to_be32(~0) };
> +       const __be32 dummy_imask[] =3D { [0 ... MAX_PHANDLE_ARGS] =3D cpu=
_to_be32(~0) };
>         u32 intsize =3D 1, addrsize;
>         int i, rc =3D -EINVAL;
>
> @@ -201,20 +221,7 @@ int of_irq_parse_raw(const __be32 *addr, struct of_p=
handle_args *out_irq)
>         if (out_irq->args_count !=3D intsize)
>                 goto fail;
>
> -       /* Look for this #address-cells. We have to implement the old lin=
ux
> -        * trick of looking for the parent here as some device-trees rely=
 on it
> -        */
> -       old =3D of_node_get(ipar);
> -       do {
> -               tmp =3D of_get_property(old, "#address-cells", NULL);
> -               tnode =3D of_get_parent(old);
> -               of_node_put(old);
> -               old =3D tnode;
> -       } while (old && tmp =3D=3D NULL);
> -       of_node_put(old);
> -       old =3D NULL;
> -       addrsize =3D (tmp =3D=3D NULL) ? 2 : be32_to_cpu(*tmp);
> -
> +       addrsize =3D of_get_address_cells(ipar);
>         pr_debug(" -> addrsize=3D%d\n", addrsize);
>
>         /* Range check so that the temporary buffer doesn't overflow */
> @@ -343,8 +350,9 @@ int of_irq_parse_one(struct device_node *device, int =
index, struct of_phandle_ar
>  {
>         struct device_node *p;
>         const __be32 *addr;
> -       u32 intsize;
> +       u32 addrsize, intsize;
>         int i, res;
> +       __be32 addr_buf[3] =3D { 0 };
>
>         pr_debug("of_irq_parse_one: dev=3D%pOF, index=3D%d\n", device, in=
dex);
>
> @@ -354,12 +362,17 @@ int of_irq_parse_one(struct device_node *device, in=
t index, struct of_phandle_ar
>
>         /* Get the reg property (if any) */
>         addr =3D of_get_property(device, "reg", NULL);

NULL here is the length returned. Use that and just copy length/4 or 3
cells, which ever is less.

> +       addrsize =3D of_get_address_cells(device);
> +
> +       /* Prevent out-of-bounds read in case of longer interrupt parent =
address size */
> +       if (addr)
> +               memcpy(addr_buf, addr, addrsize * sizeof(addrsize));

I find sizeof(addrsize) a bit odd here as it just happens to match,
but it's storage size isn't really related. I would do sizeof(__be32)
instead. Though with the above changes, you'll probably have something
like this:

if (len > (3 * sizeof(__be32))
    len =3D 3 * sizeof(__be32);

Rob


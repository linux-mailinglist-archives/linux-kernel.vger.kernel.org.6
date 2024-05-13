Return-Path: <linux-kernel+bounces-177263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E638C3C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD982817F3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D3A146A99;
	Mon, 13 May 2024 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AdaBrLDx"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B4C146A8A
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715585587; cv=none; b=AmetWCP5iBow4Lq5zRLge/1nzXVQ00GiZmPfyhKme6Amnrge0oly1CC6glt//R2hkdpRSesLjvgsYj9aP/D8SiePas4/4H9zDgN/+4XRG/t4kbl3+Gt7LDz+IDekDhXqSmk9Lon7jnNJZdaMBIc07FePg0o3SGXQV6tR+Q11ptc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715585587; c=relaxed/simple;
	bh=UPJQt02HbeTgHMsNifGKh4oMkunkySTUaJQ/nT1NUKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLnKoFrzgzpBRIUUlYVIpHOYIfNbLu7LH8jjGQczXpuf0bHqWkPRo2I/rDVmNe9hOzGBTzIjHjC/c1L1ghOr6SN2EmdYW6sLxqBgAQQisvDPOnmKarLyJvAVouokC1qj3k58L3sBZmBpiEBWLDAf6TtezvHu4u5R4e43ilBwFQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AdaBrLDx; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 314E7E001F;
	Mon, 13 May 2024 07:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715585578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nGmscOb+RgNNTwX16x2NIpkC81OXkCaqv8GhmS1ltgA=;
	b=AdaBrLDx81aISXeOcJ1wlfC5GtkrGSMwUMj+w08VjW+Vg55bCqkw48A+nPB+6UAxbslci7
	EP+hCIRpGJNsUc2Yqwlcw/GbWx0Fp2T+uc7FS7WLjLa57IjxKQ9GekXUYiXyu/Ekilf2D4
	6NVrEyHb4eWJ2El43vQmtnKGvRNjhv7g6AJUX9yEOIbc9t7qswKaEItY8euTP2O/VbT6Pw
	v8ubGRw1Zlj4J688XSq0llafwA/h4yW29MyM8g+eatjaehfdkBeyuf7eLvaft1aZ8zlJxf
	84mNssU6FVXMnub5Q70nUONJzRUvJH0r0ljcZomOxrFeBIuW7XIqo6gqrcjkhQ==
Date: Mon, 13 May 2024 09:32:56 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mtd: nand: mxc_nand: implement exec_op
Message-ID: <20240513093256.363861d1@xps-13>
In-Reply-To: <20240513091902.2c00d30a@xps-13>
References: <20240508-mtd-nand-mxc-nand-exec-op-v2-0-6b7366b7831f@pengutronix.de>
	<20240508-mtd-nand-mxc-nand-exec-op-v2-2-6b7366b7831f@pengutronix.de>
	<20240513091902.2c00d30a@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com


miquel.raynal@bootlin.com wrote on Mon, 13 May 2024 09:19:02 +0200:

> Hi Sascha,
>=20
> > @@ -1717,9 +1465,111 @@ static int mxcnd_setup_interface(struct nand_ch=
ip *chip, int chipnr,
> >  	return host->devtype_data->setup_interface(chip, chipnr, conf);
> >  }
> > =20
> > +static int mxcnd_exec_op(struct nand_chip *chip,
> > +			 const struct nand_operation *op,
> > +			 bool check_only)
> > +{
> > +	struct mxc_nand_host *host =3D nand_get_controller_data(chip);
> > +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> > +	int i, j, buf_len;
> > +	void *buf_read =3D NULL;
> > +	const void *buf_write =3D NULL;
> > +	const struct nand_op_instr *instr;
> > +	bool readid =3D false;
> > +	bool statusreq =3D false;
> > +
> > +	dev_dbg(host->dev, "%s: %d instructions\n", __func__, op->ninstrs); =
=20
>=20
> Maybe you want to get rid of this debug line.
>=20
> > +
> > +	if (check_only)
> > +		return 0;
> > +
> > +	for (i =3D 0; i < op->ninstrs; i++) {
> > +		instr =3D &op->instrs[i];
> > +
> > +		nand_op_trace("  ", instr);
> > +
> > +		switch (instr->type) {
> > +		case NAND_OP_WAITRDY_INSTR:
> > +			/*
> > +			 * NFC handles R/B internally. Therefore, this function
> > +			 * always returns status as ready. =20
>=20
> This is no longer a standalone function, maybe:
>=20
> "The controller handles the R/B pin internally, therefore there is
> nothing to do here."

And this is actually very wrong.

You should call wait_op_done() instead.

>=20
> > +			 */
> > +			break;
> > +		case NAND_OP_CMD_INSTR:
> > +			if (instr->ctx.cmd.opcode =3D=3D NAND_CMD_PAGEPROG)
> > +				host->devtype_data->send_page(mtd, NFC_INPUT);

Actually this is not the right place. You should trigger the transfer
from controller SRAM to NAND (and the other way around) in the
NAND_OP_DATA_OUT_INSTR case.

Here you should just call ->send_cmd.

> > +
> > +			host->devtype_data->send_cmd(host, instr->ctx.cmd.opcode, true);
> > +
> > +			if (instr->ctx.cmd.opcode =3D=3D NAND_CMD_READID)
> > +				readid =3D true;
> > +			if (instr->ctx.cmd.opcode =3D=3D NAND_CMD_STATUS)
> > +				statusreq =3D true;
> > +
> > +			break;
> > +		case NAND_OP_ADDR_INSTR:
> > +			for (j =3D 0; j < instr->ctx.addr.naddrs; j++) {
> > +				bool islast =3D j =3D=3D instr->ctx.addr.naddrs - 1;
> > +				host->devtype_data->send_addr(host, instr->ctx.addr.addrs[j], isla=
st);
> > +			}
> > +			break;
> > +		case NAND_OP_DATA_OUT_INSTR:
> > +			buf_write =3D instr->ctx.data.buf.out;
> > +			buf_len =3D instr->ctx.data.len;
> > +
> > +			memcpy32_toio(host->main_area0, buf_write, buf_len);
> > +			if (chip->oob_poi)
> > +				copy_spare(mtd, false, chip->oob_poi); =20
>=20
> This copy should not be needed. It should be in your page accessors if
> needed.
>=20
> > +
> > +			break;
> > +		case NAND_OP_DATA_IN_INSTR:
> > +
> > +			buf_read =3D instr->ctx.data.buf.in;
> > +			buf_len =3D instr->ctx.data.len;
> > +
> > +			if (readid) {
> > +				host->devtype_data->send_read_id(host);
> > +				readid =3D false;
> > +
> > +				memcpy32_fromio(host->data_buf, host->main_area0, buf_len * 2);
> > +
> > +				if (chip->options & NAND_BUSWIDTH_16) {
> > +					u8 *bufr =3D buf_read;
> > +					u16 *bufw =3D host->data_buf;
> > +					for (j =3D 0; j < buf_len; j++)
> > +						bufr[j] =3D bufw[j];
> > +				} else {
> > +					memcpy(buf_read, host->data_buf, buf_len);
> > +				}
> > +				break;
> > +			}
> > +
> > +			if (statusreq) {
> > +				*(u8*)buf_read =3D host->devtype_data->get_dev_status(host);
> > +				statusreq =3D false;
> > +				break;
> > +			}
> > +
> > +			host->devtype_data->read_page(chip);
> > +
> > +			if (IS_ALIGNED(buf_len, 4)) {
> > +				memcpy32_fromio(buf_read, host->main_area0, buf_len);
> > +			} else {
> > +				memcpy32_fromio(host->data_buf, host->main_area0, mtd->writesize);
> > +				memcpy(buf_read, host->data_buf, buf_len);
> > +			}
> > +
> > +			break;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +} =20
>=20
> Otherwise I'm very happy with the look.
>=20
> Thanks,
> Miqu=C3=A8l


Thanks,
Miqu=C3=A8l

